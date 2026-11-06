import '../../../models/product.dart';
import '../../../core/network/api_client.dart';

class UserRemoteDataSource {
  List<Product> _readProducts(dynamic response) {
    dynamic value = ApiClient.unwrap(response);
    if (value is Map && value['products'] is List) value = value['products'];
    if (value is List) {
      final output = <Product>[];
      for (final item in value) {
        if (item is Map) {
          if (item['products'] is List) {
            output.addAll((item['products'] as List).whereType<Map>().map((e) => Product.fromJson(Map<String, dynamic>.from(e))));
          } else {
            output.add(Product.fromAny(item));
          }
        }
      }
      return output;
    }
    return [];
  }

  Future<List<Product>> getCart() async => _readProducts(await ApiClient.get('user/getCart'));
  Future<dynamic> addCart(String id) => ApiClient.post('user/addCart', body: {'productId': id});
  Future<dynamic> deleteCart(String id) => ApiClient.delete('user/deleteCart', body: {'productId': id});
  Future<List<Product>> getFavorites() async => _readProducts(await ApiClient.get('user/getFavorite'));
  Future<dynamic> addFavorite(String id) => ApiClient.post('user/addFavorite', body: {'productId': id});
  Future<dynamic> deleteFavorite(String id) => ApiClient.delete('user/deleteFavorite', body: {'productId': id});

  Future<Map<String, dynamic>> getProfile() async {
    final response = await ApiClient.get('portfoilo/userData');
    final value = ApiClient.unwrap(response, const ['data', 'result', 'user']);
    if (value is Map) return Map<String, dynamic>.from(value);
    if (response is Map) return Map<String, dynamic>.from(response);
    return {};
  }

  Future<dynamic> updateProfile({required String name, required String phone, required String address, String image = ''}) =>
      ApiClient.post('portfoilo/editUserData', body: {'name': name, 'phone': phone, 'address': address, 'image': image});
}
