import '../../repositories/user_repository.dart';
class AddToCart {
  AddToCart(this.repository);
  final UserRepository repository;
  Future<dynamic> call(String productId) => repository.addCart(productId);
}
