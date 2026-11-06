import '../../repositories/user_repository.dart';
class RemoveFromFavorites {
  RemoveFromFavorites(this.repository);
  final UserRepository repository;
  Future<dynamic> call(String productId) => repository.deleteFavorite(productId);
}
