import '../entities/product_entity.dart';

abstract class UserRepository {
  Future<List<ProductEntity>> getCart();
  Future<dynamic> addCart(String productId);
  Future<dynamic> deleteCart(String productId);
  Future<List<ProductEntity>> getFavorites();
  Future<dynamic> addFavorite(String productId);
  Future<dynamic> deleteFavorite(String productId);
  Future<Map<String, dynamic>> getProfile();
  Future<dynamic> updateProfile({required String name, required String phone, required String address, String image = ''});
}
