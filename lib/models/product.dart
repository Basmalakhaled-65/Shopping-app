class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String image;
  final String category;
  final String brand;
  final double rating;

  const Product({
    required this.id,
    required this.title,
    this.description = '',
    this.price = 0,
    this.image = '',
    this.category = '',
    this.brand = '',
    this.rating = 0,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final images = json['images'];

    final image =
        (json['thumbnail'] ??
                json['image'] ??
                (images is List && images.isNotEmpty ? images.first : ''))
            .toString();

    return Product(
      id: (json['id'] ?? json['_id'] ?? json['productId'] ?? '').toString(),
      title: (json['title'] ?? json['name'] ?? 'Product').toString(),
      description: (json['description'] ?? '').toString(),
      price: double.tryParse((json['price'] ?? 0).toString()) ?? 0,
      image: image,
      category: (json['category'] ?? '').toString(),
      brand: (json['brand'] ?? '').toString(),
      rating: double.tryParse((json['rating'] ?? 0).toString()) ?? 0,
    );
  }

  factory Product.fromAny(dynamic value) {
    if (value is Product) {
      return value;
    }

    if (value is Map) {
      final map = Map<String, dynamic>.from(value);

      if (map['product'] is Map) {
        return Product.fromJson(Map<String, dynamic>.from(map['product']));
      }

      return Product.fromJson(map);
    }

    return const Product(id: '', title: 'Product');
  }
}
