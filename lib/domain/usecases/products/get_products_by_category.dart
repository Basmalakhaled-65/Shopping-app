import '../../entities/product_entity.dart';
import '../../repositories/product_repository.dart';
class GetProductsByCategory {
  GetProductsByCategory(this.repository);
  final ProductRepository repository;
  Future<List<ProductEntity>> call(String category) => repository.byCategory(category);
}
