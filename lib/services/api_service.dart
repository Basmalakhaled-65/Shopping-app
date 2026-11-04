import 'dart:convert';

import 'package:http/http.dart' as http;

import '../core/local_storage/token_storage.dart';
import '../core/network/api_constants.dart';

class ApiService {
  static Uri _uri(String path, [Map<String, String>? query]) {
    final baseUrl = ApiConstants.baseUrl.replaceAll(RegExp(r'/+$'), '');
    final cleanPath = path.replaceAll(RegExp(r'^/+'), '');

    final uri = Uri.parse('$baseUrl/$cleanPath');

    return query == null ? uri : uri.replace(queryParameters: query);
  }

  static Future<Map<String, String>> _headers({bool json = true}) async {
    final headers = <String, String>{'Accept': 'application/json'};

    if (json) {
      headers['Content-Type'] = 'application/json';
    }

    final token = await TokenStorage.getToken();

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = token.startsWith('Bearer ')
          ? token
          : 'Bearer $token';
    }

    return headers;
  }

  static dynamic _decode(http.Response response) {
    dynamic decoded;

    try {
      decoded = response.body.isEmpty
          ? <String, dynamic>{}
          : jsonDecode(response.body);
    } catch (_) {
      decoded = response.body;
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      String message = 'Request failed (${response.statusCode})';

      if (decoded is Map) {
        message =
            (decoded['message'] ??
                    decoded['error'] ??
                    decoded['msg'] ??
                    message)
                .toString();
      } else if (decoded is String && decoded.isNotEmpty) {
        message = decoded;
      }

      throw Exception(message);
    }

    return decoded;
  }

  static Future<dynamic> get(String path, {Map<String, String>? query}) async {
    final uri = _uri(path, query);

    print('GET REQUEST URL: $uri');

    final response = await http.get(uri, headers: await _headers());

    print('GET STATUS CODE: ${response.statusCode}');
    print('GET RESPONSE: ${response.body}');

    return _decode(response);
  }

  static Future<dynamic> post(String path, {Map<String, dynamic>? body}) async {
    final uri = _uri(path);

    print('POST REQUEST URL: $uri');

    final response = await http.post(
      uri,
      headers: await _headers(),
      body: jsonEncode(body ?? {}),
    );

    print('POST STATUS CODE: ${response.statusCode}');
    print('POST RESPONSE: ${response.body}');

    return _decode(response);
  }

  static Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    final uri = _uri(path);

    print('DELETE REQUEST URL: $uri');

    final response = await http.delete(
      uri,
      headers: await _headers(),
      body: jsonEncode(body ?? {}),
    );

    print('DELETE STATUS CODE: ${response.statusCode}');
    print('DELETE RESPONSE: ${response.body}');

    return _decode(response);
  }

  static dynamic unwrap(
    dynamic value, [
    List<String> keys = const [
      'list',
      'data',
      'result',
      'products',
      'categories',
      'brands',
      'favorites',
      'favorite',
      'cart',
      'carts',
      'user',
    ],
  ]) {
    dynamic current = value;

    for (var i = 0; i < 4; i++) {
      if (current is Map) {
        dynamic next;
        var found = false;

        for (final key in keys) {
          if (current.containsKey(key)) {
            next = current[key];
            found = true;
            break;
          }
        }

        if (!found) break;

        current = next;
      } else {
        break;
      }
    }

    return current;
  }

  static String errorMessage(Object error) {
    return error.toString().replaceFirst('Exception: ', '');
  }
}
