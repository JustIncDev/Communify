class User {
  final String id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? username;
  final DateTime? dateOfBirth;
  final String? avatar;
  final String? bio;
  final DateTime? dateOfRegistration;

  User({
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
}
