import '../../entities/product_entity.dart';
import '../../repositories/product_repository.dart';
class GetProduct {
  GetProduct(this.repository);
  final ProductRepository repository;
  Future<ProductEntity> call(String id) => repository.getProduct(id);
}
