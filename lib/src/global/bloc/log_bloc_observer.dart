import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:log_service/lib.dart';

@immutable
class LogBlocObserver extends BlocObserver {
  final bool _enabled;

  const LogBlocObserver({bool enabled = true}) : _enabled = enabled;

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (_enabled) {
      logger.logInfo(message: 'onCreate -- ${bloc.runtimeType}');
    }
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (_enabled) {
      logger.logInfo(message: 'onEvent -- ${bloc.runtimeType}, $event');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (_enabled) {
      logger.logInfo(
        message: 'onChange -- ${bloc.runtimeType}, $change',
      );
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (_enabled) {
      logger.logInfo(
        message: 'onTransition -- ${bloc.runtimeType}, $transition',
      );
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (_enabled) {
      logger.logError(
        message: 'onError -- ${bloc.runtimeType}',
        error: error,
        stackTrace: stackTrace,
      );
    }
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (_enabled) {
      logger.logInfo(
        message: 'onClose -- ${bloc.runtimeType}',
      );
    }
  }
}
