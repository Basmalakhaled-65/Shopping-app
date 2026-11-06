import '../../entities/product_entity.dart';
import '../../repositories/product_repository.dart';
class SearchProducts {
  SearchProducts(this.repository);
  final ProductRepository repository;
  Future<List<ProductEntity>> call(String query) => repository.search(query);
}
