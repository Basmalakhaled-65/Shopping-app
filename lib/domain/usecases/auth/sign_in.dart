import '../../repositories/auth_repository.dart';
class SignIn {
  SignIn(this.repository);
  final AuthRepository repository;
  Future<dynamic> call({required String email, required String password}) => repository.signIn(email: email, password: password);
}
