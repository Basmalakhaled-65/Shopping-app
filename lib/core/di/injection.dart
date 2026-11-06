import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/repositories/user_repository.dart';

/// Lightweight dependency composition root. Can be replaced by a DI package later.
class Injection {
  Injection._();
  static final Injection instance = Injection._();

  final ProductRepository productRepository = ProductRepositoryImpl();
  final UserRepository userRepository = UserRepositoryImpl();
  final AuthRepository authRepository = AuthRepositoryImpl();
}
