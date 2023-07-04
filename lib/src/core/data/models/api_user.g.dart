// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiUser _$ApiUserFromJson(Map<String, dynamic> json) => ApiUser(
      id: json['id'] as String,
      email: json['email'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      username: json['username'] as String?,
      dateOfBirth: json['date_of_birth'] == null
          ? null
          : DateTime.parse(json['date_of_birth'] as String),
      avatar: json['avatar'] as String?,
      bio: json['bio'] as String?,
      dateOfRegistration: json['date_of_registration'] == null
          ? null
          : DateTime.parse(json['date_of_registration'] as String),
    );

Map<String, dynamic> _$ApiUserToJson(ApiUser instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'username': instance.username,
      'date_of_birth': instance.dateOfBirth?.toIso8601String(),
      'avatar': instance.avatar,
      'bio': instance.bio,
      'date_of_registration': instance.dateOfRegistration?.toIso8601String(),
    };
