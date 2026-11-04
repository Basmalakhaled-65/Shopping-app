import 'dart:convert';
import '../core/local_storage/token_storage.dart';
import 'api_service.dart';

class AuthService {
  static String pendingResetEmail = '';

  static Future<dynamic> signUp({required String name, required String phone, required String email, required String password, required String confirmPassword}) async {
    return ApiService.post('auth/signUp', body: {'name': name, 'phone': phone, 'email': email, 'password': password, 'confirmPassword': confirmPassword});
  }

  static Future<dynamic> signIn({required String email, required String password}) async {
    final result = await ApiService.post('auth/signIn', body: {'email': email, 'password': password});
    if (result is Map) {
      final token = result['token'] ?? result['accessToken'] ?? result['access_token'] ?? (result['data'] is Map ? result['data']['token'] : null);
      if (token != null) await TokenStorage.saveToken(token.toString());
      await TokenStorage.saveUser(jsonEncode(result['user'] ?? result['data'] ?? result));
    }
    return result;
  }

  static Future<dynamic> sendResetCode(String email) async {
    pendingResetEmail = email;
    return ApiService.post('auth/resetPassCode', body: {'email': email});
  }

  static Future<dynamic> activateResetCode(String code) async {
    return ApiService.post('auth/activeResetPass', body: {'email': pendingResetEmail, 'code': code});
  }

  static Future<dynamic> resetPassword(String password, String confirmPassword) async {
    return ApiService.post('auth/resetPassword', body: {'email': pendingResetEmail, 'password': password, 'confirmPassword': confirmPassword});
  }
}