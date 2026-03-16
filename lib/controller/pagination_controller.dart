import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:managementt/model/pagination_models.dart';

/// Generic pagination controller for handling infinite scroll in lists.
/// This controller can be extended for any list endpoint that supports pagination.
///
/// Features:
/// - Automatic pagination on scroll (80% threshold)
/// - Prevents duplicate API requests
/// - Handles end-of-data detection
/// - Supports pull-to-refresh
/// - Error recovery
///
/// Usage:
/// ```dart
/// class MyListController extends PaginationController<MyItem> {
///   @override
///   Future<PaginatedResponse<MyItem>> fetchPage(int page, int size) {
///     return myService.getItemsPaginated(page, size);
///   }
/// }
/// ```
abstract class PaginationController<T> extends GetxController {
  /// List of items loaded so far
  var items = <T>[].obs;

  /// Current pagination state
  var paginationState = PaginationState().obs;

  /// Scroll controller for detecting when user reaches bottom
  late ScrollController scrollController;

  /// Page size for each API request
  static const int defaultPageSize = 10;

  @override
  void onInit() {
    super.onInit();
    _initScrollController();
    _loadFirstPage();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  /// Initialize scroll controller and set up listener for pagination trigger.
  /// Triggers loadNextPage when user scrolls to 80% of the list.
  void _initScrollController() {
    scrollController = ScrollController();
    scrollController.addListener(_handleScroll);
  }

  /// Called when user scrolls. Detects 80% threshold and triggers pagination.
  void _handleScroll() {
    if (!scrollController.hasClients) return;

    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.offset;
    double scrollThreshold = maxScroll * 0.80;

    // Trigger load when scrolling to 80% of list height
    if (currentScroll >= scrollThreshold) {
      final state = paginationState.value;
      if (!state.isLoading && state.hasMore) {
        loadNextPage();
      }
    }
  }

  /// Load the first page of data. Called on initialization and on refresh.
  Future<void> _loadFirstPage() async {
    try {
      resetPagination();
      await loadNextPage();
    } catch (e) {
      paginationState.value = paginationState.value.copyWith(
        error: 'Failed to load data: ${e.toString()}',
        isLoading: false,
      );
    }
  }

  /// Load next page of data from API.
  /// - Prevents duplicate requests
  /// - Appends items to existing list
  /// - Handles end-of-data detection
  /// - Updates error state on failure
  Future<void> loadNextPage() async {
    final state = paginationState.value;

    // Guard clauses: don't load if already loading, at end of data, or after error
    if (state.isLoading || !state.hasMore) return;

    paginationState.value = state.copyWith(isLoading: true, error: null);

    try {
      final nextPage = state.currentPage + 1;

      // Fetch data from API (implemented by subclass)
      final response = await fetchPage(nextPage, defaultPageSize);

      // Append new items to existing list
      items.addAll(response.content);

      // Update pagination state
      paginationState.value = state.copyWith(
        currentPage: nextPage,
        isLoading: false,
        hasMore: response.hasMore,
        error: null,
      );
    } catch (e) {
      paginationState.value = state.copyWith(
        isLoading: false,
        error: 'Error loading more data: ${e.toString()}',
      );
    }
  }

  /// Reset pagination to initial state (for pull-to-refresh).
  /// Clears all items and resets page counter.
  void resetPagination() {
    items.clear();
    paginationState.value = PaginationState();
  }

  /// Retry loading after an error occurred.
  Future<void> retryLoadingAfterError() async {
    paginationState.value = paginationState.value.copyWith(error: null);
    await loadNextPage();
  }

  /// Must be implemented by subclass to fetch paginated data from API endpoint.
  /// Should return a PaginatedResponse containing the next page of items.
  ///
  /// Parameters:
  /// - page: Zero-indexed page number
  /// - size: Number of items per page
  ///
  /// Returns: PaginatedResponse<T> with content, page info, and totals
  Future<PaginatedResponse<T>> fetchPage(int page, int size);

  /// Check if list is empty
  bool get isEmpty => items.isEmpty;

  /// Check if we're still on first page
  bool get isFirstPage => paginationState.value.currentPage == 0;

  /// Get total count of items loaded so far
  int get itemCount => items.length;
}
