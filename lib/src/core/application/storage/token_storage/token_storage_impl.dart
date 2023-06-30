import 'package:shared_preferences/shared_preferences.dart';

import 'token_storage.dart';

/// Persistent storage for auth tokens.
///
/// Based on SharedPreferences.
final class TokenStorageImpl implements ITokenStorage {
  static const String _accessToken = 'access_token';
  static const String _accessExpiresIn = 'access_expires_in';
  static const String _refreshToken = 'refresh_token';

  /// Create an instance [TokenStorageImpl].
  TokenStorageImpl();

  @override
  Future<({String? accessToken, String? expiresIn})> getAccessToken() async {
    return (
      accessToken: (await SharedPreferences.getInstance()).getString(_accessToken),
      expiresIn: (await SharedPreferences.getInstance()).getString(_accessExpiresIn),
    );
  }

  @override
  Future<String?> getRefreshToken() async {
    return (await SharedPreferences.getInstance()).getString(_refreshToken);
  }

  @override
  Future<void> setAccessToken(String accessToken, String expiresIn) async {
    await (await SharedPreferences.getInstance()).setString(_accessToken, accessToken);
    await (await SharedPreferences.getInstance()).setString(_accessExpiresIn, expiresIn);
  }

  @override
  Future<void> setRefreshToken(String refreshToken) async {
    await (await SharedPreferences.getInstance()).setString(_refreshToken, refreshToken);
  }
}
