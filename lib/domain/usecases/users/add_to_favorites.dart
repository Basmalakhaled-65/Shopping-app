import '../../repositories/user_repository.dart';
class AddToFavorites {
  AddToFavorites(this.repository);
  final UserRepository repository;
  Future<dynamic> call(String productId) => repository.addFavorite(productId);
}
