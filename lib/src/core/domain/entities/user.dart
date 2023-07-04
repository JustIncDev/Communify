class UserDomain {
  final String id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? dateOfBirth;
  final String? avatar;
  final String? bio;
  final String? dateOfRegistration;

  UserDomain({
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

  UserDomain copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? username,
    String? dateOfBirth,
    String? avatar,
    String? bio,
    String? dateOfRegistration,
  }) {
    return UserDomain(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio,
      dateOfRegistration: dateOfRegistration ?? this.dateOfRegistration,
    );
  }
}
