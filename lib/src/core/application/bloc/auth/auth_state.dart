import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {}

final class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthAuthenticated extends AuthState {
  AuthAuthenticated();

  @override
  List<Object?> get props => [];
}

final class AuthUnauthenticated extends AuthState {
  AuthUnauthenticated();

  @override
  List<Object?> get props => [];
}

final class AuthFailure extends AuthState {
  final String errorMessage;

  AuthFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
