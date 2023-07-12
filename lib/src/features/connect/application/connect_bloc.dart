import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:log_service/lib.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/domain/entities/auth_request.dart';
import '../../../core/domain/repositories/auth_repository.dart';
import '../../../core/domain/repositories/profile_repository.dart';
import '../../../core/util/api_error.dart';
import '../../../core/util/enum.dart';
import '../../../core/util/util.dart';

part 'connect_event.dart';
part 'connect_state.dart';

class ConnectBloc extends Bloc<ConnectEvent, ConnectState> {
  ConnectBloc(
    IAuthRepository authRepository,
    IProfileRepository profileRepository,
  )   : _authRepository = authRepository,
        _profileRepository = profileRepository,
        super(ConnectInitial()) {
    on<ConnectEmailEvent>(_onSignUpWithEmail);
    on<ConnectSocialNetworkEvent>(_onConnectSocialNetwork);

    _authStateSubscription =
        Supabase.instance.client.auth.onAuthStateChange.listen((event) {
      if (event.event == AuthChangeEvent.signedIn) {
        _handleConnectResult();
      }
    });
  }

  final IAuthRepository _authRepository;
  final IProfileRepository _profileRepository;
  StreamSubscription? _authStateSubscription;

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }

  Future<void> _onSignUpWithEmail(
      ConnectEmailEvent event, Emitter<ConnectState> emit) async {
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

  Future<void> _onSignInWithEmail(
      ConnectEmailEvent event, Emitter<ConnectState> emit) async {
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

  Future<void> _onConnectSocialNetwork(
      ConnectSocialNetworkEvent event, Emitter<ConnectState> emit) async {
    try {
      emit(ConnectLoading());
      var result = false;
      if (event.socialMediaType == SocialProviders.twitter) {
        result = await _authRepository.signInWithTwitter();
      } else if (event.socialMediaType == SocialProviders.discord) {
        result = await _authRepository.signInWithDiscord();
      }
      if (!result) {
        throw Exception('Error during ${event.socialMediaType} login');
      }
    } on Object catch (e, s) {
      logger.logError(message: e.toString(), error: e, stackTrace: s);
      emit(ConnectFailure(e.toString()));
    }
  }

  Future<void> _handleConnectResult() async {
    final userData = await _profileRepository.getUserProfile();
    if (userData.username != null) {
      emit(ConnectLoginSuccess());
    } else {
      emit(ConnectRegistrationSuccess());
    }
  }
}
