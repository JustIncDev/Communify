import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../api/api_service.dart';
import 'auth_remote_data_source.dart';

final class AuthRemoteDataSourceImpl implements IAuthRemoteDataSource {
  final ApiService _apiService;
  final SupabaseClient _supabaseClient;

  AuthRemoteDataSourceImpl(Dio dio)
      : _apiService = ApiService(dio),
        _supabaseClient = Supabase.instance.client;

  @override
  Future<AuthResponse> signUpWithEmail(String email, String password) async {
    return _supabaseClient.auth.signUp(
      email: email,
      password: password,
    );
  }

  @override
  Future<AuthResponse> signInWithEmail(String email, String password) async {
    return _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<User?> getCurrentUser() async {
    return _supabaseClient.auth.currentUser;
  }
}
