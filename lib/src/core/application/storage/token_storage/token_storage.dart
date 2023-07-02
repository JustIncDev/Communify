/// Persistent storage for tokens.
abstract interface class ITokenStorage {
  /// Returns access_token and access_expires_in
  Future<({String? accessToken, int? expiresIn})> getAccessToken();

  /// Save access_token and access_expires_in
  Future<void> setAccessToken(String accessToken, int? expiresIn);

  /// Returns refresh_token
  Future<String?> getRefreshToken();

  /// Save refresh_token
  Future<void> setRefreshToken(String? refreshToken);
}
