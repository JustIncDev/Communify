import '../../entities/token_response.dart';
import '../../entities/user_data.dart';

abstract interface class IAuthRemoteDataSource {
  Future<UserData> signInWithEmail(String email);

  Future<UserData> signInWithApple();

  Future<UserData> signInWithGoggle();

  Future<UserData> signInWithTwitter();

  Future<UserData> signInWithDiscord();

  // Future<UserData> signInWithMetamask();

  Future<TokenResponse> refreshToken(String refreshToken);
}
