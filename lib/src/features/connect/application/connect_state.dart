part of 'connect_bloc.dart';

enum FieldType {
  email,
  password,
}

sealed class ConnectState extends Equatable {}

final class ConnectInitial extends ConnectState {
  @override
  List<Object> get props => [];
}

final class ConnectLoading extends ConnectState {
  @override
  List<Object?> get props => [];
}

final class ConnectFailure extends ConnectState {
  final String message;

  ConnectFailure(this.message);

  @override
  List<Object?> get props => [];
}

base class ConnectRegistrationSuccess extends ConnectState {
  @override
  List<Object?> get props => [];
}

base class ConnectLoginSuccess extends ConnectState {
  @override
  List<Object?> get props => [];
}

final class ConnectInputError extends ConnectState {
  final Map<FieldType, String> errors;

  ConnectInputError({required this.errors});

  @override
  List<Object?> get props => [errors];
}
