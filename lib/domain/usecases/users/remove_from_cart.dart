import '../../repositories/user_repository.dart';
class RemoveFromCart {
  RemoveFromCart(this.repository);
  final UserRepository repository;
  Future<dynamic> call(String productId) => repository.deleteCart(productId);
}
