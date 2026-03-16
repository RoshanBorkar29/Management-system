import 'package:get/get.dart';
import 'package:managementt/controller/pagination_controller.dart';
import 'package:managementt/model/pagination_models.dart';
import 'package:managementt/model/task.dart';
import 'package:managementt/service/task_pagination_service.dart';

/// Pagination controller for tasks dashboard.
/// Extends PaginationController to handle infinite scrolling for task lists.
class TaskPaginationController extends PaginationController<Task> {
  final TaskPaginationService _taskService = TaskPaginationService();
  var searchQuery = ''.obs;

  @override
  Future<PaginatedResponse<Task>> fetchPage(int page, int size) {
    return _taskService.getTasksPaginated(page, size);
  }

  /// Update search query and filter items locally.
  /// This is client-side filtering on loaded items.
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  /// Get filtered list based on search query.
  /// Filters from already loaded items, not from API.
  List<Task> getFilteredItems() {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) {
      return items.toList();
    }
    return items
        .where((task) => task.title.toLowerCase().contains(query))
        .toList();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
