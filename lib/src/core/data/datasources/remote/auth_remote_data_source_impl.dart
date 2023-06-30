import 'package:dio/dio.dart';

import '../../entities/token_response.dart';
import '../../entities/user_data.dart';
import '../api/supabase_api_service.dart';
import 'auth_remote_data_source.dart';

final class AuthRemoteDataSourceImpl implements IAuthRemoteDataSource {
  final SupabaseApiService _supabaseApiService;

  AuthRemoteDataSourceImpl(Dio dio) : _supabaseApiService = SupabaseApiService(dio);

  @override
  Future<UserData> signInWithApple() {
    throw UnimplementedError();
  }

  @override
  Future<UserData> signInWithDiscord() {
    throw UnimplementedError();
  }

  @override
  Future<UserData> signInWithEmail(String email) {
    throw UnimplementedError();
  }

  @override
  Future<UserData> signInWithGoggle() {
    throw UnimplementedError();
  }

  @override
  Future<UserData> signInWithTwitter() {
    throw UnimplementedError();
  }

  @override
  Future<TokenResponse> refreshToken(String refreshToken) async {
    try {
      final response = await _supabaseApiService.refreshAccessToken(refreshToken);
      return response;
    } on Object catch (e) {
      throw Exception('Failed to refresh token: $e');
    }
  }
}
