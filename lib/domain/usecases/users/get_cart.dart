import '../../entities/product_entity.dart';
import '../../repositories/user_repository.dart';
class GetCart {
  GetCart(this.repository);
  final UserRepository repository;
  Future<List<ProductEntity>> call() => repository.getCart();
}
