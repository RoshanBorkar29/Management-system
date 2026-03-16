import 'package:managementt/model/pagination_models.dart';
import 'package:managementt/model/member.dart';
import 'api_service.dart';

/// Service for fetching paginated member data from the backend.
/// Provides methods for loading team members with pagination.
class MemberPaginationService {
  static final MemberPaginationService _instance =
      MemberPaginationService._internal();
  factory MemberPaginationService() => _instance;
  MemberPaginationService._internal();

  final ApiService _api = ApiService();

  /// Fetch paginated members (team members with role='USER').
  ///
  /// Parameters:
  /// - page: Zero-indexed page number
  /// - size: Number of items per page
  ///
  /// Returns: PaginatedResponse<Member> containing members for the page
  Future<PaginatedResponse<Member>> getMembersPaginated(int page, int size) {
    return _api.getPaginated(
      '/members/paginated',
      page,
      size,
      (json) => Member.fromJson(json),
    );
  }
}
