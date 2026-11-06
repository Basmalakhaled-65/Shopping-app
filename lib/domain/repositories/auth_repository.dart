abstract class AuthRepository {
  Future<dynamic> signUp({required String name, required String phone, required String email, required String password, required String confirmPassword});
  Future<dynamic> signIn({required String email, required String password});
  Future<dynamic> sendResetCode(String email);
  Future<dynamic> activateResetCode(String email, String code);
  Future<dynamic> resetPassword(String email, String password, String confirmPassword);
}
