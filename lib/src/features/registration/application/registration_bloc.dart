import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<RegistrationGroupEvent>(_onGroupTypeSelected);
  }

  void _onGroupTypeSelected(RegistrationGroupEvent event, Emitter<RegistrationState> emit) {
    if (event is RegistrationJoinGroupEvent) {
      emit(const RegistrationChooseNetworkFinished(createGroup: false));
    } else if (event is RegistrationCreateGroupEvent) {
      emit(const RegistrationChooseNetworkFinished(createGroup: true));
    }
  }
}
