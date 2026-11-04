import '../models/product.dart';
import 'api_service.dart';

class ProductService {
  static List<Product> _products(dynamic response) {
    final value = ApiService.unwrap(response, const [
      'list',
      'data',
      'result',
      'products',
    ]);

    if (value is List) {
      return value
          .whereType<Map>()
          .map((e) => Product.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }

    return [];
  }

  static Future<List<Product>> getProducts({
    int skip = 0,
    int limit = 20,
  }) async {
    final response = await ApiService.get(
      'home/products',
      query: {'skip': '$skip', 'limit': '$limit'},
    );

    return _products(response);
  }

  static Future<Product> getProduct(String id) async {
    final response = await ApiService.get('home/products/$id');

    final value = ApiService.unwrap(response, const [
      'list',
      'data',
      'result',
      'product',
    ]);

    if (value is Map) {
      return Product.fromJson(Map<String, dynamic>.from(value));
    }

    if (response is Map) {
      return Product.fromJson(Map<String, dynamic>.from(response));
    }

    throw Exception('Invalid product response');
  }

  static Future<List<Product>> search(String query) async {
    if (query.trim().isEmpty) {
      return getProducts();
    }

    final response = await ApiService.post(
      'home/productsFilter',
      body: {'search': query.trim(), 'skip': 0, 'limit': 30},
    );

    return _products(response);
  }

  static Future<List<String>> getCategories() async {
    final response = await ApiService.get('home/categories/names');

    final value = ApiService.unwrap(response, const [
      'list',
      'data',
      'result',
      'categories',
    ]);

    if (value is List) {
      return value
          .map(
            (e) => e is Map
                ? (e['name'] ?? e['slug'] ?? e['title'] ?? '').toString()
                : e.toString(),
          )
          .where((e) => e.isNotEmpty)
          .toList();
    }

    return [];
  }

  static Future<List<Product>> byCategory(String category) async {
    final response = await ApiService.get(
      'home/products/category/${Uri.encodeComponent(category)}',
      query: {'skip': '0', 'limit': '30'},
    );

    return _products(response);
  }
}
