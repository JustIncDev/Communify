part of 'services.dart';

class AliceLoggerService implements LogServiceInterface {
  AliceLoggerService({
    this.enabled = true,
  }) : _instance = Alice();

  final Alice _instance;
  @override
  final bool enabled;

  Alice get aliceInstance => _instance;

  @override
  void logError({
    required String message,
    required Object error,
    StackTrace? stackTrace,
    Map<String, Object>? additionalArgs,
  }) {
    _instance.addLog(
      AliceLog(
        message: _formatAliceLogMessage(
          DiagnosticLevel.error.name,
          message,
          error: error,
          stackTrace: stackTrace,
        ),
      ),
    );
  }

  @override
  void logInfo({required Object message}) {
    _instance.addLog(
      AliceLog(
        message: _formatAliceLogMessage(
          DiagnosticLevel.info.name,
          message.toString(),
        ),
      ),
    );
  }

  @override
  void logWarning({required Object message, StackTrace? stackTrace}) {
    _instance.addLog(
      AliceLog(
        message: _formatAliceLogMessage(
          DiagnosticLevel.warning.name,
          message.toString(),
          stackTrace: stackTrace,
        ),
      ),
    );
  }

  String _formatAliceLogMessage(String level, String message,
      {Object? error, StackTrace? stackTrace}) {
    final buffer = StringBuffer()
      ..writeln('[$level] $message')
      ..writeln('Timestamp: ${DateTime.now()}');

    if (error != null) {
      buffer.writeln('Error: $error');
    }

    if (stackTrace != null) {
      buffer.writeln('StackTrace: $stackTrace');
    }

    return buffer.toString();
  }
}
