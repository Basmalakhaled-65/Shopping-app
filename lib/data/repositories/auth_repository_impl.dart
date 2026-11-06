import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({AuthRemoteDataSource? remote}) : _remote = remote ?? AuthRemoteDataSource();
  final AuthRemoteDataSource _remote;
  @override Future<dynamic> signUp({required String name, required String phone, required String email, required String password, required String confirmPassword}) => _remote.signUp(name: name, phone: phone, email: email, password: password, confirmPassword: confirmPassword);
  @override Future<dynamic> signIn({required String email, required String password}) => _remote.signIn(email: email, password: password);
  @override Future<dynamic> sendResetCode(String email) => _remote.sendResetCode(email);
  @override Future<dynamic> activateResetCode(String email, String code) => _remote.activateResetCode(email, code);
  @override Future<dynamic> resetPassword(String email, String password, String confirmPassword) => _remote.resetPassword(email, password, confirmPassword);
}
