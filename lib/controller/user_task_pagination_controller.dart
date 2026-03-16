import 'package:get/get.dart';
import 'package:managementt/controller/auth_controller.dart';
import 'package:managementt/controller/pagination_controller.dart';
import 'package:managementt/model/pagination_models.dart';
import 'package:managementt/model/task.dart';
import 'package:managementt/service/task_pagination_service.dart';

/// Pagination controller for user's task dashboard.
/// Loads and displays tasks (type=TASK) assigned to the current user.
class UserTaskPaginationController extends PaginationController<Task> {
  final TaskPaginationService _taskService = TaskPaginationService();
  var searchQuery = ''.obs;

  @override
  Future<PaginatedResponse<Task>> fetchPage(int page, int size) async {
    final userId = Get.find<AuthController>().currentUserId.value;
    return _taskService.getTasksByOwnerPaginated(userId, page, size);
  }

  /// Update search query and filter items locally.
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  /// Get filtered list based on search query.
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
