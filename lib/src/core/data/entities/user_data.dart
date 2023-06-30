import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData {
  final int id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? username;
  final DateTime? dateOfBirth;
  final String? avatar;
  final String? bio;
  final DateTime? dateOfRegistration;

  UserData({
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

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
