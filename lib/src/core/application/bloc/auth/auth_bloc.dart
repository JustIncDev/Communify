import 'package:bloc/bloc.dart';

import '../../../data/repositories/auth_repository_impl.dart';
import '../../../domain/auth/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

final class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authenticationRepository;

  AuthBloc({
    required IAuthRepository authenticationRepository,
    required AuthState initState,
  })  : _authenticationRepository = authenticationRepository,
        super(initState) {
    on<AppStarted>(_onAppStarted);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final isAuthenticated = await _authenticationRepository.isUserAuthenticated();
      if (isAuthenticated) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnauthenticated());
      }
    } on Object catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
