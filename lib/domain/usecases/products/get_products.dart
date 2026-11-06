import '../../entities/product_entity.dart';
import '../../repositories/product_repository.dart';
class GetProducts {
  GetProducts(this.repository);
  final ProductRepository repository;
  Future<List<ProductEntity>> call({int skip = 0, int limit = 20}) => repository.getProducts(skip: skip, limit: limit);
}
