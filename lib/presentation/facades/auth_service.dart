import '../../core/di/injection.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/auth/sign_in.dart';
import '../../domain/usecases/auth/sign_up.dart';

/// Compatibility facade. Sign-in/sign-up use Domain Use Cases.
class AuthService {
  static String pendingResetEmail = '';
  static AuthRepository get _repository => Injection.instance.authRepository;

  static Future<dynamic> signUp({required String name, required String phone, required String email, required String password, required String confirmPassword}) =>
      SignUp(_repository)(name: name, phone: phone, email: email, password: password, confirmPassword: confirmPassword);
  static Future<dynamic> signIn({required String email, required String password}) => SignIn(_repository)(email: email, password: password);
  static Future<dynamic> sendResetCode(String email) async {
    pendingResetEmail = email;
    return _repository.sendResetCode(email);
  }
  static Future<dynamic> activateResetCode(String code) => _repository.activateResetCode(pendingResetEmail, code);
  static Future<dynamic> resetPassword(String password, String confirmPassword) => _repository.resetPassword(pendingResetEmail, password, confirmPassword);
}
