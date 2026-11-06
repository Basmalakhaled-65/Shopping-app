import '../../core/di/injection.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/products/get_categories.dart';
import '../../domain/usecases/products/get_product.dart';
import '../../domain/usecases/products/get_products.dart';
import '../../domain/usecases/products/get_products_by_category.dart';
import '../../domain/usecases/products/search_products.dart';
import '../../models/product.dart';

/// Compatibility facade for existing screens. All product business operations
/// pass through Domain Use Cases; screens can be migrated to direct use-case
/// injection without changing the data layer.
class ProductService {
  static final _repository = Injection.instance.productRepository;

  static Product _toModel(ProductEntity e) => Product(
    id: e.id, title: e.title, description: e.description, price: e.price,
    image: e.image, category: e.category, brand: e.brand, rating: e.rating,
  );

  static Future<List<Product>> getProducts({int skip = 0, int limit = 20}) async =>
      (await GetProducts(_repository)(skip: skip, limit: limit)).map(_toModel).toList();
  static Future<Product> getProduct(String id) async => _toModel(await GetProduct(_repository)(id));
  static Future<List<Product>> search(String query) async =>
      (await SearchProducts(_repository)(query)).map(_toModel).toList();
  static Future<List<String>> getCategories() => GetCategories(_repository)();
  static Future<List<Product>> byCategory(String category) async =>
      (await GetProductsByCategory(_repository)(category)).map(_toModel).toList();
}
