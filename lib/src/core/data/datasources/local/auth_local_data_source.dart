import 'dart:async';

abstract interface class IAuthLocalDataSource {
  FutureOr<({String? accessToken, int? expiresIn, String? refreshToken})> retrieveTokensData();

  Future<void> setTokensData({
    required String accessToken,
    required int? expiresIn,
    required String? refreshToken,
  });
}
