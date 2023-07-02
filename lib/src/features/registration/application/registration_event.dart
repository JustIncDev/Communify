part of 'registration_bloc.dart';

sealed class RegistrationEvent extends Equatable {
  const RegistrationEvent();
}

abstract base class RegistrationGroupEvent extends RegistrationEvent {}

final class RegistrationCreateGroupEvent extends RegistrationGroupEvent {
  @override
  List<Object?> get props => [];
}

final class RegistrationJoinGroupEvent extends RegistrationGroupEvent {
  @override
  List<Object?> get props => [];
}
