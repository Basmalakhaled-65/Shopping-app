import '../../entities/product_entity.dart';
import '../../repositories/user_repository.dart';
class GetFavorites {
  GetFavorites(this.repository);
  final UserRepository repository;
  Future<List<ProductEntity>> call() => repository.getFavorites();
}
