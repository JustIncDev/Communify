import 'dart:async';

abstract interface class IAuthLocalDataSource {
  FutureOr<({String? accessToken, String? expiresIn, String? refreshToken})> retrieveTokensData();

  Future<void> setTokensData({
    required String accessToken,
    required String expiresIn,
    required String refreshToken,
  });
}
