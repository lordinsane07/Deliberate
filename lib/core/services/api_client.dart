import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';

class ApiClient {
  ApiClient._();

  static const Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
  };

  static Uri _buildUri(String path) {
    return Uri.parse('${AppConfig.baseUrl}$path');
  }

  static Future<dynamic> get(
    String path, {
    Map<String, String>? headers,
  }) async {
    final response = await http.get(
      _buildUri(path),
      headers: {..._defaultHeaders, if (headers != null) ...headers},
    );

    return _processResponse(response);
  }

  static Future<dynamic> post(
    String path, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final response = await http.post(
      _buildUri(path),
      headers: {..._defaultHeaders, if (headers != null) ...headers},
      body: body != null ? jsonEncode(body) : null,
    );

    return _processResponse(response);
  }

  static dynamic _processResponse(http.Response response) {
    final status = response.statusCode;

    if (status >= 200 && status < 300) {
      if (response.body.isEmpty) {
        return {};
      }
      return jsonDecode(response.body);
    }

    String errorMessage = response.body.isNotEmpty
        ? response.body
        : 'Unexpected error occurred';

    if (response.body.isNotEmpty) {
      try {
        final decoded = jsonDecode(response.body);
        if (decoded is Map && decoded.containsKey('message')) {
          errorMessage = decoded['message'];
        }
      } catch (_) {
        // Use raw body if decode fails
      }
    }

    throw ApiException(statusCode: status, message: errorMessage);
  }
}

class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException({required this.statusCode, required this.message});

  @override
  String toString() => 'ApiException($statusCode): $message';
}
