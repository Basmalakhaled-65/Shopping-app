import '../../../models/product.dart';
import '../../../core/network/api_client.dart';

class ProductRemoteDataSource {
  List<Product> _products(dynamic response) {
    final value = ApiClient.unwrap(response, const ['list', 'data', 'result', 'products']);
    if (value is List) {
      return value.whereType<Map>().map((e) => Product.fromJson(Map<String, dynamic>.from(e))).toList();
    }
    return [];
  }

  Future<List<Product>> getProducts({int skip = 0, int limit = 20}) async =>
      _products(await ApiClient.get('home/products', query: {'skip': '$skip', 'limit': '$limit'}));

  Future<Product> getProduct(String id) async {
    final response = await ApiClient.get('home/products/$id');
    final value = ApiClient.unwrap(response, const ['list', 'data', 'result', 'product']);
    if (value is Map) return Product.fromJson(Map<String, dynamic>.from(value));
    if (response is Map) return Product.fromJson(Map<String, dynamic>.from(response));
    throw Exception('Invalid product response');
  }

  Future<List<Product>> search(String query) async {
    if (query.trim().isEmpty) return getProducts();
    return _products(await ApiClient.post('home/productsFilter', body: {'search': query.trim(), 'skip': 0, 'limit': 30}));
  }

  Future<List<String>> getCategories() async {
    final value = ApiClient.unwrap(await ApiClient.get('home/categories/names'), const ['list', 'data', 'result', 'categories']);
    if (value is List) return value.map((e) => e is Map ? (e['name'] ?? e['slug'] ?? e['title'] ?? '').toString() : e.toString()).where((e) => e.isNotEmpty).toList();
    return [];
  }

  Future<List<Product>> byCategory(String category) async =>
      _products(await ApiClient.get('home/products/category/${Uri.encodeComponent(category)}', query: {'skip': '0', 'limit': '30'}));
}
