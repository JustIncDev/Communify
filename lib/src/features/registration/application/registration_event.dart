part of 'registration_bloc.dart';

sealed class RegistrationEvent extends Equatable {}

abstract base class RegistrationGroupEvent extends RegistrationEvent {}

final class RegistrationCreateGroupEvent extends RegistrationGroupEvent {
  @override
  List<Object?> get props => [];
}

final class RegistrationJoinGroupEvent extends RegistrationGroupEvent {
  @override
  List<Object?> get props => [];
}

final class RegistrationAgreeEvent extends RegistrationEvent {
  final String firstName;
  final String lastName;
  final String username;
  final String dateOfBirth;

  RegistrationAgreeEvent({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.dateOfBirth,
  });

  @override
  List<Object?> get props => [firstName, lastName, username, dateOfBirth];
}

final class RegistrationSelectThemeGroupEvent extends RegistrationEvent {
  final String groupTheme;
  final bool other;

  RegistrationSelectThemeGroupEvent(this.groupTheme, {this.other = false});

  @override
  List<Object?> get props => [groupTheme, other];
}

final class RegistrationCreateGroupFinishEvent extends RegistrationEvent {
  final String groupName;
  final String groupTheme;

  RegistrationCreateGroupFinishEvent({
    required this.groupName,
    required this.groupTheme,
  });

  @override
  List<Object?> get props => [groupName, groupTheme];
}

final class RegistrationSuccessInitEvent extends RegistrationEvent {
  @override
  List<Object?> get props => [];
}

final class RegistrationFillFirstProfilePageEvent extends RegistrationEvent {
  final XFile profilePicture;
  final String bioDescription;

  RegistrationFillFirstProfilePageEvent(
      {required this.profilePicture, required this.bioDescription});

  @override
  List<Object?> get props => [profilePicture, bioDescription];
}

final class RegistrationFillSecondProfilePageEvent extends RegistrationEvent {
  final Map<SocialMediaType, String> providers;

  RegistrationFillSecondProfilePageEvent(this.providers);

  @override
  List<Object?> get props => [providers];
}
