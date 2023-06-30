import 'package:json_annotation/json_annotation.dart';

part 'token_response.g.dart';

@JsonSerializable()
class TokenResponse {
  final String accessToken;
  final String refreshToken;
  final int expiresInSeconds;

  TokenResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresInSeconds,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) => _$TokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);
}
