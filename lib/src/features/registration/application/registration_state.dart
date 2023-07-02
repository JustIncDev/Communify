part of 'registration_bloc.dart';

sealed class RegistrationState extends Equatable {
  const RegistrationState();
}

class RegistrationInitial extends RegistrationState {
  @override
  List<Object> get props => [];
}

class RegistrationChooseNetworkFinished extends RegistrationState {
  final bool createGroup;

  const RegistrationChooseNetworkFinished({this.createGroup = false});

  @override
  List<Object?> get props => [createGroup];
}
