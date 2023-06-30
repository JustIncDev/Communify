/// Persistent storage for tokens.
abstract interface class ITokenStorage {
  /// Returns access_token and access_expires_in
  Future<({String? accessToken, String? expiresIn})> getAccessToken();

  /// Save access_token and access_expires_in
  Future<void> setAccessToken(String accessToken, String expiresIn);

  /// Returns refresh_token
  Future<String?> getRefreshToken();

  /// Save refresh_token
  Future<void> setRefreshToken(String refreshToken);
}
