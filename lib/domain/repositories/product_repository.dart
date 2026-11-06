import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getProducts({int skip = 0, int limit = 20});
  Future<ProductEntity> getProduct(String id);
  Future<List<ProductEntity>> search(String query);
  Future<List<String>> getCategories();
  Future<List<ProductEntity>> byCategory(String category);
}
