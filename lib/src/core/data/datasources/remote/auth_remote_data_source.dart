import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class IAuthRemoteDataSource {
  Future<AuthResponse> signUpWithEmail(String email, String password);

  Future<AuthResponse> signInWithEmail(String email, String password);

  Future<User?> getCurrentUser();
}
