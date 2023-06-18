library logger;

import 'package:flutter/material.dart';
import 'package:l/l.dart';

export 'services/services.dart';

/// Interface for services where logs will be proxied
abstract class LogServiceInterface {
  final bool enabled;

  LogServiceInterface({this.enabled = true});

  void logError({
    required String message,
    required Object error,
    StackTrace? stackTrace,
    Map<String, Object>? additionalArgs,
  });

  void logInfo({required Object message});

  void logWarning({required Object message, StackTrace? stackTrace});
}

/// Logging manager
class LogServiceManager {
  final List<LogServiceInterface> _logServices;
  static late final LogServiceManager _instance;

  LogServiceManager._internal(this._logServices);

  factory LogServiceManager() => _instance;

  static void init(List<LogServiceInterface> logServices) {
    _instance = LogServiceManager._internal(logServices);
  }

  /// Sets up custom error handling for Flutter errors using the l logging library
  static void setUpCustomFlutterErrorHandling() {
    final originalFlutterErrorCallback = FlutterError.onError;
    FlutterError.onError = (details) {
      l.w(details.exceptionAsString(), details.stack);
      originalFlutterErrorCallback?.call(details);
    };
  }

  void logError({
    required String message,
    required Object error,
    StackTrace? stackTrace,
    Map<String, Object>? additionalArgs,
  }) {
    for (final service in _logServices) {
      if (service.enabled) {
        service.logError(
          message: message,
          error: error,
          stackTrace: stackTrace,
          additionalArgs: additionalArgs,
        );
      }
    }
  }

  void logInfo({required Object message}) {
    for (final service in _logServices) {
      if (service.enabled) {
        service.logInfo(message: message);
      }
    }
  }
}
