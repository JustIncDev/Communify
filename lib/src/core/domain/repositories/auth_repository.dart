import '../../data/models/bad_words.dart';
import '../entities/auth_request.dart';
import '../entities/user.dart';

abstract interface class IAuthRepository {
  Future<UserDomain?> getCurrentUser();

  Future<bool> isUserAuthenticated();

  Future<void> refreshToken(String refreshToken);

  Future<UserDomain?> signUpWithEmail(AuthRequest request);

  Future<void> signInWithEmail(AuthRequest request);

  Future<bool> checkForBadWord(BadWordsRequest request);

  Future<bool> signInWithTwitter();

  Future<bool> signInWithDiscord();
}
