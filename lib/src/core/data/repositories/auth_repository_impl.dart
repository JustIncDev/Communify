import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../application/storage/token_storage/token_storage.dart';
import '../../domain/auth/auth_repository.dart';
import '../datasources/local/auth_local_data_source.dart';
import '../datasources/local/auth_local_data_source_impl.dart';
import '../datasources/remote/auth_remote_data_source.dart';
import '../datasources/remote/auth_remote_data_source_impl.dart';
import '../entities/user_data.dart';

final class AuthRepositoryImpl implements IAuthRepository {
  final IAuthLocalDataSource _authLocalDataSource;
  final IAuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(Dio dio)
      : _authLocalDataSource = AuthLocalDataSourceImpl(),
        _authRemoteDataSource = AuthRemoteDataSourceImpl(dio);

  @override
  UserData? getCurrentUser() {
    throw UnimplementedError();
  }

  @override
  Future<bool> isUserAuthenticated() async {
    final tokensData = await _authLocalDataSource.retrieveTokensData();

    if (tokensData.accessToken == null && tokensData.expiresIn == null) {
      return false;
    }

    if (tokensData.expiresIn == null ||
        DateTime.now().isAfter(
            DateTime.fromMillisecondsSinceEpoch(int.parse(tokensData.expiresIn.toString()) * 1000)
                .add(DateTime.now().timeZoneOffset))) {
      if (tokensData.refreshToken != null) {
        await refreshToken(tokensData.refreshToken!);
      } else {
        return false;
      }
    }

    return true;
  }

  @override
  Future<void> refreshToken(String refreshToken) async {
    final response = await _authRemoteDataSource.refreshToken(refreshToken);
    await _authLocalDataSource.setTokensData(
      accessToken: response.accessToken,
      expiresIn: response.expiresInSeconds.toString(),
      refreshToken: response.refreshToken,
    );
  }
}
