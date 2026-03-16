import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:managementt/config.dart';
import 'package:managementt/controller/auth_controller.dart';
import 'package:managementt/model/pagination_models.dart';

/// Centralized HTTP client that automatically attaches JWT headers
/// and handles 401 → token refresh → retry logic.
class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  AuthController get _auth => AuthController.to;

  // ── Header helpers ──────────────────────────────────────────────

  Map<String, String> _authHeaders({bool json = false}) {
    final headers = <String, String>{
      'Authorization': 'Bearer ${_auth.accessToken.value}',
    };
    if (json) headers['Content-Type'] = 'application/json';
    return headers;
  }

  // ── Public HTTP methods ─────────────────────────────────────────

  Future<http.Response> get(String path) async {
    final response = await http.get(
      Uri.parse('${Config.baseUrl}$path'),
      headers: _authHeaders(),
    );
    return _handleResponse(response, () => get(path));
  }

  Future<http.Response> post(String path, {Object? body}) async {
    final response = await http.post(
      Uri.parse('${Config.baseUrl}$path'),
      headers: _authHeaders(json: true),
      body: body is String ? body : jsonEncode(body),
    );
    return _handleResponse(response, () => post(path, body: body));
  }

  Future<http.Response> put(String path, {Object? body}) async {
    final response = await http.put(
      Uri.parse('${Config.baseUrl}$path'),
      headers: _authHeaders(json: true),
      body: body is String ? body : jsonEncode(body),
    );
    return _handleResponse(response, () => put(path, body: body));
  }

  Future<http.Response> delete(String path) async {
    final response = await http.delete(
      Uri.parse('${Config.baseUrl}$path'),
      headers: _authHeaders(),
    );
    return _handleResponse(response, () => delete(path));
  }

  // ── Token refresh + retry logic ─────────────────────────────────

  /// If the response is 401, attempt a token refresh and retry once.
  Future<http.Response> _handleResponse(
    http.Response response,
    Future<http.Response> Function() retryRequest,
  ) async {
    if (response.statusCode == 401) {
      final refreshed = await _refreshToken();
      if (refreshed) {
        return retryRequest();
      } else {
        await _auth.logout();
        throw Exception('Session expired. Please log in again.');
      }
    }
    return response;
  }

  /// Call /auth/refresh with the current refresh token.
  /// Returns true if the token was successfully refreshed.
  Future<bool> _refreshToken() async {
    try {
      final response = await http.post(
        Uri.parse('${Config.baseUrl}/auth/refresh'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refreshToken': _auth.refreshToken.value}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final newAccessToken = data['accessToken'] as String;
        await _auth.updateAccessToken(newAccessToken);
        return true;
      }
      return false;
    } catch (e) {
      print('ApiService: Token refresh failed — $e');
      return false;
    }
  }

  /// Fetch paginated data from an endpoint.
  ///
  /// Parameters:
  /// - path: API endpoint path (e.g., '/tasks/paginated/PROJECT')
  /// - page: Page number (zero-indexed)
  /// - size: Items per page
  /// - fromJson: Function to convert JSON to model object
  ///
  /// Returns: PaginatedResponse<T> with pagination metadata
  Future<PaginatedResponse<T>> getPaginated<T>(
    String path,
    int page,
    int size,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    // Build URL with pagination parameters
    final uri = Uri.parse('${Config.baseUrl}$path').replace(
      queryParameters: {'page': page.toString(), 'size': size.toString()},
    );

    final response = await http.get(uri, headers: _authHeaders());

    final handled = await _handleResponse(
      response,
      () => http.get(uri, headers: _authHeaders()),
    );

    if (handled.statusCode != 200) {
      throw Exception('Failed to load paginated data: ${handled.statusCode}');
    }

    final json = jsonDecode(handled.body) as Map<String, dynamic>;
    return PaginatedResponse<T>.fromJson(json, fromJson);
  }
}
