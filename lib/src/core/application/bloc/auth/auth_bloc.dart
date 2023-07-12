import 'package:bloc/bloc.dart';

import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/repositories/profile_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

final class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authenticationRepository;
  final IProfileRepository _profileRepository;

  AuthBloc({
    required IAuthRepository authenticationRepository,
    required IProfileRepository profileRepository,
    required AuthState initState,
  })  : _authenticationRepository = authenticationRepository,
        _profileRepository = profileRepository,
        super(initState) {
    on<AppStarted>(_onAppStarted);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final isAuthenticated =
          await _authenticationRepository.isUserAuthenticated();
      if (isAuthenticated) {
        final userData = await _profileRepository.getUserProfile();
        if (userData.username != null) {
          emit(AuthAuthenticated());
        } else {
          emit(AuthRegistrationNotFinished());
        }
      } else {
        emit(AuthUnauthenticated());
      }
    } on Object catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
