import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

part 'api_user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ApiUser {
  final String id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? username;
  final DateTime? dateOfBirth;
  final String? avatar;
  final String? bio;
  final DateTime? dateOfRegistration;

  ApiUser({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.username,
    this.dateOfBirth,
    this.avatar,
    this.bio,
    this.dateOfRegistration,
  });

  factory ApiUser.fromJson(Map<String, dynamic> json) {
    return ApiUser(
      id: json['id'] as String,
      email: json['email'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      username: json['username'] as String?,
      dateOfBirth: json['date_of_birth'] != null
          ? DateFormat('yyyy/MM/dd').parse(json['date_of_birth'] as String)
          : null,
      avatar: json['avatar'] as String?,
      bio: json['bio'] as String?,
      dateOfRegistration: json['date_of_registration'] == null
          ? null
          : DateTime.parse(json['date_of_registration'] as String),
    );
  }

  Map<String, dynamic> toJson() => _$ApiUserToJson(this);
}
