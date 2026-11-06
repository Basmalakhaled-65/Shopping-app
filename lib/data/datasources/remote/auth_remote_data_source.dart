import 'dart:convert';
import '../../../core/local_storage/token_storage.dart';
import '../../../core/network/api_client.dart';

class AuthRemoteDataSource {
  static String pendingResetEmail = '';

  Future<dynamic> signUp({required String name, required String phone, required String email, required String password, required String confirmPassword}) =>
      ApiClient.post('auth/signUp', body: {'name': name, 'phone': phone, 'email': email, 'password': password, 'confirmPassword': confirmPassword});

  Future<dynamic> signIn({required String email, required String password}) async {
    final result = await ApiClient.post('auth/signIn', body: {'email': email, 'password': password});
    if (result is Map) {
      final token = result['token'] ?? result['accessToken'] ?? result['access_token'] ?? (result['data'] is Map ? result['data']['token'] : null);
      if (token != null) await TokenStorage.saveToken(token.toString());
      await TokenStorage.saveUser(jsonEncode(result['user'] ?? result['data'] ?? result));
    }
    return result;
  }

  Future<dynamic> sendResetCode(String email) async {
    pendingResetEmail = email;
    return ApiClient.post('auth/resetPassCode', body: {'email': email});
  }
  Future<dynamic> activateResetCode(String email, String code) => ApiClient.post('auth/activeResetPass', body: {'email': email, 'code': code});
  Future<dynamic> resetPassword(String email, String password, String confirmPassword) => ApiClient.post('auth/resetPassword', body: {'email': email, 'password': password, 'confirmPassword': confirmPassword});
}
