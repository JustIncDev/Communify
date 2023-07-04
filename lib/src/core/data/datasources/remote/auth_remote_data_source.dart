import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/bad_words.dart';

abstract interface class IAuthRemoteDataSource {
  Future<AuthResponse> signUpWithEmail(String email, String password);

  Future<AuthResponse> signInWithEmail(String email, String password);

  Future<User?> getCurrentUser();

  Future<BadWordsResponse> checkForBadWord(BadWordsRequest request);
}
