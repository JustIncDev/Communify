import 'package:dio/dio.dart';

import '../../domain/auth/auth_repository.dart';
import '../../domain/entities/auth_request.dart';
import '../../domain/entities/user.dart';
import '../datasources/local/auth_local_data_source.dart';
import '../datasources/local/auth_local_data_source_impl.dart';
import '../datasources/remote/auth_remote_data_source.dart';
import '../datasources/remote/auth_remote_data_source_impl.dart';
import 'package:gotrue/src/types/auth_response.dart';

final class AuthRepositoryImpl implements IAuthRepository {
  final IAuthLocalDataSource _authLocalDataSource;
  final IAuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(Dio dio)
      : _authLocalDataSource = AuthLocalDataSourceImpl(),
        _authRemoteDataSource = AuthRemoteDataSourceImpl(dio);

  @override
  User? getCurrentUser() {
    throw UnimplementedError();
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
  Future<User?> signUpWithEmail(AuthRequest request) async {
    final response = await _authRemoteDataSource.signUpWithEmail(request.email, request.password);
    return _getUserAndSessionData(response);
  }

  @override
  Future<User?> signInWithEmail(AuthRequest request) async {
    final response = await _authRemoteDataSource.signInWithEmail(request.email, request.password);
    return _getUserAndSessionData(response);
  }

  Future<User?> _getUserAndSessionData(AuthResponse response) async {
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
      return User(id: userData.id, email: userData.email);
    } else {
      return null;
    }
  }
}
