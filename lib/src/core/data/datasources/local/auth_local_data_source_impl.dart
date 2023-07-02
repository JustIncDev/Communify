import 'dart:async';

import '../../../application/storage/token_storage/token_storage.dart';
import '../../../application/storage/token_storage/token_storage_impl.dart';
import 'auth_local_data_source.dart';

final class AuthLocalDataSourceImpl implements IAuthLocalDataSource {
  final ITokenStorage _tokenStorage;

  AuthLocalDataSourceImpl() : _tokenStorage = TokenStorageImpl();

  @override
  FutureOr<({String? accessToken, int? expiresIn, String? refreshToken})>
      retrieveTokensData() async {
    final accessTokenData = await _tokenStorage.getAccessToken();
    final refreshTokenData = await _tokenStorage.getRefreshToken();
    return (
      accessToken: accessTokenData.accessToken,
      expiresIn: accessTokenData.expiresIn,
      refreshToken: refreshTokenData
    );
  }

  @override
  Future<void> setTokensData({
    required String accessToken,
    required int? expiresIn,
    required String? refreshToken,
  }) async {
    await _tokenStorage.setAccessToken(accessToken, expiresIn);
    await _tokenStorage.setRefreshToken(refreshToken);
  }
}
