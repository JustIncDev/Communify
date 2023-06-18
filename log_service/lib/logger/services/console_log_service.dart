part of 'services.dart';

class ConsoleLogService implements LogServiceInterface {
  @override
  final bool enabled;

  ConsoleLogService({this.enabled = true});

  @override
  void logError({
    required String message,
    required Object error,
    StackTrace? stackTrace,
    Map<String, Object>? additionalArgs,
  }) {
    l.capture(
      () => l.e(message, stackTrace),
      LogOptions(handlePrint: true, messageFormatting: _messageFormatting),
    );
  }

  @override
  void logInfo({required Object message}) {
    l.capture(
      () => l.i(message),
      LogOptions(handlePrint: true, messageFormatting: _messageFormatting),
    );
  }

  @override
  void logWarning({
    required Object message,
    StackTrace? stackTrace,
  }) {
    l.capture(
      () => l.w(message, stackTrace),
      LogOptions(handlePrint: true, messageFormatting: _messageFormatting),
    );
  }

  Object _messageFormatting(Object message, LogLevel logLevel, DateTime now) =>
      '${_timeFormat(now)} | $message';

  String _timeFormat(DateTime time) => '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
}
