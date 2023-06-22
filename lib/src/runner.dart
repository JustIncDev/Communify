import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:log_service/lib.dart';

import 'app.dart';
import 'global/di/app_scope.dart';

/// App launch.
Future<void> run() async {
  await runZonedGuarded(
    initializeAndRunApp,
    handleError,
  );
}

Future<void> initializeAndRunApp() async {
  /// It must be called so that the orientation does not fall.
  WidgetsFlutterBinding.ensureInitialized();

  /// Fix orientation.
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  /// Initialization LogServiceManager
  await AppScope.initLoggerServices();

  final scope = AppScope();
  await scope.initTheme();
  runApp(CommunifyApp(scope));
}

void handleError(Object error, StackTrace stackTrace) {
  logger.logError(
    message: 'An async error occurred: $error',
    error: error,
    stackTrace: stackTrace,
  );
}
