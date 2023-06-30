// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      id: json['id'] as int,
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      username: json['username'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      avatar: json['avatar'] as String?,
      bio: json['bio'] as String?,
      dateOfRegistration: json['dateOfRegistration'] == null
          ? null
          : DateTime.parse(json['dateOfRegistration'] as String),
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'username': instance.username,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'avatar': instance.avatar,
      'bio': instance.bio,
      'dateOfRegistration': instance.dateOfRegistration?.toIso8601String(),
    };
