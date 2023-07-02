import '../entities/auth_request.dart';
import '../entities/user.dart';

abstract interface class IAuthRepository {
  User? getCurrentUser();

  Future<bool> isUserAuthenticated();

  Future<void> refreshToken(String refreshToken);

  Future<User?> signUpWithEmail(AuthRequest request);

  Future<void> signInWithEmail(AuthRequest request);
}
