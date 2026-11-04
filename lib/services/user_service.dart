import '../models/product.dart';
import 'api_service.dart';

class UserService {
  static List<Product> _readProducts(dynamic response) {
    dynamic value = ApiService.unwrap(response);
    if (value is Map && value['products'] is List) value = value['products'];
    if (value is List) {
      final out = <Product>[];
      for (final item in value) {
        if (item is Map) {
          if (item['products'] is List) {
            out.addAll((item['products'] as List).whereType<Map>().map((e) => Product.fromJson(Map<String, dynamic>.from(e))));
          } else {
            out.add(Product.fromAny(item));
          }
        }
      }
      return out;
    }
    return [];
  }

  static Future<List<Product>> getCart() async => _readProducts(await ApiService.get('user/getCart'));
  static Future<dynamic> addCart(String productId) => ApiService.post('user/addCart', body: {'productId': productId});
  static Future<dynamic> deleteCart(String productId) => ApiService.delete('user/deleteCart', body: {'productId': productId});
  static Future<List<Product>> getFavorites() async => _readProducts(await ApiService.get('user/getFavorite'));
  static Future<dynamic> addFavorite(String productId) => ApiService.post('user/addFavorite', body: {'productId': productId});
  static Future<dynamic> deleteFavorite(String productId) => ApiService.delete('user/deleteFavorite', body: {'productId': productId});
  static Future<Map<String, dynamic>> getProfile() async {
    final response = await ApiService.get('portfoilo/userData');
    final value = ApiService.unwrap(response, const ['data', 'result', 'user']);
    if (value is Map) return Map<String, dynamic>.from(value);
    if (response is Map) return Map<String, dynamic>.from(response);
    return {};
  }
  static Future<dynamic> updateProfile({required String name, required String phone, required String address, String image = ''}) => ApiService.post('portfoilo/editUserData', body: {'name': name, 'phone': phone, 'address': address, 'image': image});
}