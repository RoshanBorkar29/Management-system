import 'package:managementt/model/pagination_models.dart';
import 'package:managementt/model/task.dart';
import 'api_service.dart';

/// Service for fetching paginated task data from the backend.
/// Provides methods for loading projects (type=PROJECT) and tasks (type=TASK) with pagination.
class TaskPaginationService {
  static final TaskPaginationService _instance =
      TaskPaginationService._internal();
  factory TaskPaginationService() => _instance;
  TaskPaginationService._internal();

  final ApiService _api = ApiService();

  /// Fetch paginated projects (Tasks with type='PROJECT').
  ///
  /// Parameters:
  /// - page: Zero-indexed page number
  /// - size: Number of items per page
  ///
  /// Returns: PaginatedResponse<Task> containing projects for the page
  Future<PaginatedResponse<Task>> getProjectsPaginated(int page, int size) {
    return _api.getPaginated(
      '/tasks/paginated/PROJECT',
      page,
      size,
      (json) => Task.fromJson(json),
    );
  }

  /// Fetch paginated tasks (Tasks with type='TASK').
  ///
  /// Parameters:
  /// - page: Zero-indexed page number
  /// - size: Number of items per page
  ///
  /// Returns: PaginatedResponse<Task> containing tasks for the page
  Future<PaginatedResponse<Task>> getTasksPaginated(int page, int size) {
    return _api.getPaginated(
      '/tasks/paginated/TASK',
      page,
      size,
      (json) => Task.fromJson(json),
    );
  }

  /// Fetch paginated tasks owned by a specific user.
  ///
  /// Parameters:
  /// - ownerId: ID of the task owner
  /// - page: Zero-indexed page number
  /// - size: Number of items per page
  ///
  /// Returns: PaginatedResponse<Task> containing owner's tasks for the page
  Future<PaginatedResponse<Task>> getTasksByOwnerPaginated(
    String ownerId,
    int page,
    int size,
  ) {
    return _api.getPaginated(
      '/tasks/paginated/owner/$ownerId',
      page,
      size,
      (json) => Task.fromJson(json),
    );
  }
}
