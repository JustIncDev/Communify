import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {}

final class AppStarted extends AuthEvent {
  @override
  List<Object?> get props => [];
}
