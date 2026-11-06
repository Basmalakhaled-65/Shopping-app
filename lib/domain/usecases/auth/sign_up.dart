import '../../repositories/auth_repository.dart';
class SignUp {
  SignUp(this.repository);
  final AuthRepository repository;
  Future<dynamic> call({required String name, required String phone, required String email, required String password, required String confirmPassword}) => repository.signUp(name: name, phone: phone, email: email, password: password, confirmPassword: confirmPassword);
}
