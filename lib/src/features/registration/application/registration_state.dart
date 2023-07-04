part of 'registration_bloc.dart';

sealed class RegistrationState extends Equatable {}

class RegistrationInitial extends RegistrationState {
  @override
  List<Object> get props => [];
}

class RegistrationChooseNetworkFinished extends RegistrationState {
  final bool createGroup;

  RegistrationChooseNetworkFinished({this.createGroup = false});

  @override
  List<Object?> get props => [createGroup];
}

final class RegistrationInputError extends RegistrationState {
  final Map<FieldType, String> errors;

  RegistrationInputError({required this.errors});

  @override
  List<Object?> get props => [errors];
}

final class RegistrationLoading extends RegistrationState {
  @override
  List<Object> get props => [];
}

final class RegistrationAgreeSuccess extends RegistrationState {
  @override
  List<Object> get props => [];
}

final class RegistrationSelectThemeGroupSuccessState extends RegistrationState {
  final String groupTheme;

  RegistrationSelectThemeGroupSuccessState(this.groupTheme);

  @override
  List<Object?> get props => [groupTheme];
}

final class RegistrationFinishGroupCreateState extends RegistrationState {
  final String groupName;

  RegistrationFinishGroupCreateState(this.groupName);

  @override
  List<Object?> get props => [groupName];
}

final class RegistrationFinishInitializeSuccessState extends RegistrationState {
  final String username;

  RegistrationFinishInitializeSuccessState(this.username);

  @override
  List<Object?> get props => [username];
}

final class RegistrationFillFirstPageSuccessState extends RegistrationState {
  @override
  List<Object?> get props => [];
}

final class RegistrationFillSecondPageSuccessState extends RegistrationState {
  @override
  List<Object?> get props => [];
}

final class RegistrationFailure extends RegistrationState {
  final String message;

  RegistrationFailure(this.message);

  @override
  List<Object?> get props => [];
}
