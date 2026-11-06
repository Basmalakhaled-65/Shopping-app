import '../../repositories/product_repository.dart';
class GetCategories {
  GetCategories(this.repository);
  final ProductRepository repository;
  Future<List<String>> call() => repository.getCategories();
}
