import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/bad_words.dart';
import '../api/api_service.dart';
import 'auth_remote_data_source.dart';

final class AuthRemoteDataSourceImpl implements IAuthRemoteDataSource {
  final ApiLayerService _apiLayerService;
  final SupabaseClient _supabaseClient;

  AuthRemoteDataSourceImpl(Dio dio)
      : _apiLayerService = ApiLayerService(dio),
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

  @override
  Future<BadWordsResponse> checkForBadWord(BadWordsRequest request) {
    return _apiLayerService.checkForBadWord(request.toJson());
  }
}
