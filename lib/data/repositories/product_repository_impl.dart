import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../../models/product.dart';
import '../datasources/remote/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({ProductRemoteDataSource? remote}) : _remote = remote ?? ProductRemoteDataSource();
  final ProductRemoteDataSource _remote;
  ProductEntity _entity(Product p) => ProductEntity(id: p.id, title: p.title, description: p.description, price: p.price, image: p.image, category: p.category, brand: p.brand, rating: p.rating);

  @override Future<List<ProductEntity>> getProducts({int skip = 0, int limit = 20}) async => (await _remote.getProducts(skip: skip, limit: limit)).map(_entity).toList();
  @override Future<ProductEntity> getProduct(String id) async => _entity(await _remote.getProduct(id));
  @override Future<List<ProductEntity>> search(String query) async => (await _remote.search(query)).map(_entity).toList();
  @override Future<List<String>> getCategories() => _remote.getCategories();
  @override Future<List<ProductEntity>> byCategory(String category) async => (await _remote.byCategory(category)).map(_entity).toList();

  // UI compatibility helpers return the existing data model.
  Future<List<Product>> getProductsModel({int skip = 0, int limit = 20}) => _remote.getProducts(skip: skip, limit: limit);
  Future<Product> getProductModel(String id) => _remote.getProduct(id);
  Future<List<Product>> searchModel(String query) => _remote.search(query);
  Future<List<Product>> byCategoryModel(String category) => _remote.byCategory(category);
}
