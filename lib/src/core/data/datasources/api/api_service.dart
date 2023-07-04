import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/bad_words.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;
}

@RestApi(baseUrl: 'https://api.apilayer.com')
abstract class ApiLayerService extends ApiService {
  factory ApiLayerService(Dio dio, {String baseUrl}) = _ApiLayerService;

  @POST('/bad_words')
  Future<BadWordsResponse> checkForBadWord(
    @Body() Map<String, dynamic> body, [
    @Query('censor_character') String censorCharacter = '*',
    @Header('apikey') String apiKey = const String.fromEnvironment('BAD_WORDS_API_URL'),
  ]);
}
