import '../../core/di/injection.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/users/add_to_cart.dart';
import '../../domain/usecases/users/add_to_favorites.dart';
import '../../domain/usecases/users/get_cart.dart';
import '../../domain/usecases/users/get_favorites.dart';
import '../../domain/usecases/users/remove_from_cart.dart';
import '../../domain/usecases/users/remove_from_favorites.dart';
import '../../models/product.dart';

/// Compatibility facade. Cart and favorite actions run through Domain Use Cases.
class UserService {
  static final _repository = Injection.instance.userRepository;
  static Product _toModel(ProductEntity e) => Product(
    id: e.id, title: e.title, description: e.description, price: e.price,
    image: e.image, category: e.category, brand: e.brand, rating: e.rating,
  );

  static Future<List<Product>> getCart() async => (await GetCart(_repository)()).map(_toModel).toList();
  static Future<dynamic> addCart(String productId) => AddToCart(_repository)(productId);
  static Future<dynamic> deleteCart(String productId) => RemoveFromCart(_repository)(productId);
  static Future<List<Product>> getFavorites() async => (await GetFavorites(_repository)()).map(_toModel).toList();
  static Future<dynamic> addFavorite(String productId) => AddToFavorites(_repository)(productId);
  static Future<dynamic> deleteFavorite(String productId) => RemoveFromFavorites(_repository)(productId);
  static Future<Map<String, dynamic>> getProfile() => _repository.getProfile();
  static Future<dynamic> updateProfile({required String name, required String phone, required String address, String image = ''}) =>
      _repository.updateProfile(name: name, phone: phone, address: address, image: image);
}
