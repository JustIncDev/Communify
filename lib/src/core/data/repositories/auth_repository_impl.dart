import 'package:dio/dio.dart';
import 'package:gotrue/src/types/auth_response.dart';

import '../../domain/entities/auth_request.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local/auth_local_data_source.dart';
import '../datasources/local/auth_local_data_source_impl.dart';
import '../datasources/remote/auth_remote_data_source.dart';
import '../datasources/remote/auth_remote_data_source_impl.dart';
import '../models/bad_words.dart';

final class AuthRepositoryImpl implements IAuthRepository {
  final IAuthLocalDataSource _authLocalDataSource;
  final IAuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(Dio dio)
      : _authLocalDataSource = AuthLocalDataSourceImpl(),
        _authRemoteDataSource = AuthRemoteDataSourceImpl(dio);

  @override
  Future<UserDomain?> getCurrentUser() async {
    final response = await _authRemoteDataSource.getCurrentUser();
    if (response != null) {
      return UserDomain(id: response.id, email: response.email);
    } else {
      return null;
    }
  }

  @override
  Future<bool> isUserAuthenticated() async {
    final response = await _authRemoteDataSource.getCurrentUser();
    if (response != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> refreshToken(String refreshToken) async {
    throw UnimplementedError();
  }

  @override
  Future<UserDomain?> signUpWithEmail(AuthRequest request) async {
    final response = await _authRemoteDataSource.signUpWithEmail(
        request.email, request.password);
    return _getUserAndSessionData(response);
  }

  @override
  Future<UserDomain?> signInWithEmail(AuthRequest request) async {
    final response = await _authRemoteDataSource.signInWithEmail(
        request.email, request.password);
    return _getUserAndSessionData(response);
  }

  Future<UserDomain?> _getUserAndSessionData(AuthResponse response) async {
    final userData = response.user;
    final tokenData = response.session;
    if (tokenData != null) {
      await _authLocalDataSource.setTokensData(
        accessToken: tokenData.accessToken,
        expiresIn: tokenData.expiresIn ?? -1,
        refreshToken: tokenData.refreshToken ?? '',
      );
    }
    if (userData != null) {
      return UserDomain(id: userData.id, email: userData.email);
    } else {
      return null;
    }
  }

  @override
  Future<bool> checkForBadWord(BadWordsRequest request) async {
    final response = await _authRemoteDataSource.checkForBadWord(request);
    if ((response.badWordsTotal ?? 0) > 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> signInWithDiscord() {
    return _authRemoteDataSource.signInWithDiscord();
  }

  @override
  Future<bool> signInWithTwitter() {
    return _authRemoteDataSource.signInWithTwitter();
  }
}
