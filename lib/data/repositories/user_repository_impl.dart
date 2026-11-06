import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../../models/product.dart';
import '../datasources/remote/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({UserRemoteDataSource? remote}) : _remote = remote ?? UserRemoteDataSource();
  final UserRemoteDataSource _remote;
  ProductEntity _entity(Product p) => ProductEntity(id: p.id, title: p.title, description: p.description, price: p.price, image: p.image, category: p.category, brand: p.brand, rating: p.rating);
  @override Future<List<ProductEntity>> getCart() async => (await _remote.getCart()).map(_entity).toList();
  @override Future<dynamic> addCart(String productId) => _remote.addCart(productId);
  @override Future<dynamic> deleteCart(String productId) => _remote.deleteCart(productId);
  @override Future<List<ProductEntity>> getFavorites() async => (await _remote.getFavorites()).map(_entity).toList();
  @override Future<dynamic> addFavorite(String productId) => _remote.addFavorite(productId);
  @override Future<dynamic> deleteFavorite(String productId) => _remote.deleteFavorite(productId);
  @override Future<Map<String, dynamic>> getProfile() => _remote.getProfile();
  @override Future<dynamic> updateProfile({required String name, required String phone, required String address, String image = ''}) => _remote.updateProfile(name: name, phone: phone, address: address, image: image);

  Future<List<Product>> getCartModel() => _remote.getCart();
  Future<List<Product>> getFavoritesModel() => _remote.getFavorites();
}
