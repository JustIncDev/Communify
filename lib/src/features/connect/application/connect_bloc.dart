import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:log_service/lib.dart';
import 'package:retrofit/http.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/domain/entities/auth_request.dart';
import '../../../core/domain/repositories/auth_repository.dart';
import '../../../core/util/api_error.dart';
import '../../../core/util/enum.dart';
import '../../../core/util/util.dart';

part 'connect_event.dart';
part 'connect_state.dart';

class ConnectBloc extends Bloc<ConnectEvent, ConnectState> {
  ConnectBloc(IAuthRepository authRepository)
      : _authRepository = authRepository,
        super(ConnectInitial()) {
    on<ConnectEmailEvent>(_onSignUpWithEmail);
  }

  final IAuthRepository _authRepository;

  Future<void> _onSignUpWithEmail(ConnectEmailEvent event, Emitter<ConnectState> emit) async {
    final validationEmailMessage = validateEmail(event.email);
    final validationPasswordMessage = validatePassword(event.password);

    late final errorMessages = <FieldType, String>{};

    if (validationEmailMessage != null) {
      errorMessages.addAll({FieldType.email: validationEmailMessage});
    }

    if (validationPasswordMessage != null) {
      errorMessages.addAll({FieldType.password: validationPasswordMessage});
    }

    if (errorMessages.isNotEmpty) {
      emit(ConnectInputError(errors: errorMessages));
      return;
    }

    try {
      emit(ConnectLoading());
      final userData = await _authRepository.signUpWithEmail(
        AuthRequest(
          email: event.email,
          password: event.password,
        ),
      );
      if (userData != null) {
        emit(ConnectRegistrationSuccess());
      } else {
        throw Exception('User is not created');
      }
    } on AuthException catch (e, s) {
      final errorType = getTypeFromMessage(e.message);
      if (errorType == ServerError.userAlreadyExists) {
        await _onSignInWithEmail(event, emit);
      } else {
        emit(ConnectFailure(e.message));
      }
    } on Object catch (e, s) {
      logger.logError(message: e.toString(), error: e, stackTrace: s);
      emit(ConnectFailure(e.toString()));
    }
  }

  Future<void> _onSignInWithEmail(ConnectEmailEvent event, Emitter<ConnectState> emit) async {
    try {
      await _authRepository.signInWithEmail(
        AuthRequest(
          email: event.email,
          password: event.password,
        ),
      );
      emit(ConnectLoginSuccess());
    } on AuthException catch (e, s) {
      final errorType = getTypeFromMessage(e.message);
      if (errorType == ServerError.invalidCredentials) {
        emit(ConnectFailure(e.message));
      }
    } on Object catch (e, s) {
      logger.logError(message: e.toString(), error: e, stackTrace: s);
      emit(ConnectFailure(e.toString()));
    }
  }
}
