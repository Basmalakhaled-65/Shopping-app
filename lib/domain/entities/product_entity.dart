/// Core business representation of a product, independent from JSON/API details.
class ProductEntity {
  final String id;
  final String title;
  final String description;
  final double price;
  final String image;
  final String category;
  final String brand;
  final double rating;

  const ProductEntity({
    required this.id,
    required this.title,
    this.description = '',
    this.price = 0,
    this.image = '',
    this.category = '',
    this.brand = '',
    this.rating = 0,
  });
}
