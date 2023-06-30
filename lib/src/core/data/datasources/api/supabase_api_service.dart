import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../entities/token_response.dart';

part 'supabase_api_service.g.dart';

const apiKey = String.fromEnvironment('ANON_KEY');

@RestApi(baseUrl: String.fromEnvironment('PROJECT_URL'))
abstract class SupabaseApiService {
  factory SupabaseApiService(Dio dio, {String baseUrl}) = _SupabaseApiService;

  @POST('/auth/v1/token?grant_type=refresh_token')
  Future<TokenResponse> refreshAccessToken(@Field('refresh_token') String refreshToken);
}
