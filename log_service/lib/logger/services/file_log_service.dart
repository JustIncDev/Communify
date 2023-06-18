part of 'services.dart';

class FileLogService implements LogServiceInterface {
  final String fileName;
  final int bufferSize;
  final List<Map<String, Object?>> _buffer = [];
  final _lock = Lock();
  @override
  final bool enabled;

  FileLogService({
    this.fileName = 'logs.txt',
    this.bufferSize = 10,
    this.enabled = true,
  });

  @override
  Future<void> logError({
    required String message,
    required Object error,
    StackTrace? stackTrace,
    Map<String, Object>? additionalArgs,
  }) async {
    final logData = {
      'type': 'Error',
      'message': message,
      'error': error.toString(),
      'stackTrace': stackTrace?.toString(),
      'additionalArgs': additionalArgs,
      'timestamp': DateTime.now().toIso8601String(),
    };

    await _bufferLog(logData);
  }

  @override
  Future<void> logInfo({required Object message}) async {
    final logData = {
      'type': 'Info',
      'message': message.toString(),
      'timestamp': DateTime.now().toIso8601String(),
    };

    await _bufferLog(logData);
  }

  @override
  Future<void> logWarning({required Object message, StackTrace? stackTrace}) async {
    final logData = {
      'type': 'Warning',
      'message': message.toString(),
      'stackTrace': stackTrace?.toString(),
      'timestamp': DateTime.now().toIso8601String(),
    };

    await _bufferLog(logData);
  }

  Future<void> _bufferLog(Map<String, Object?> logData) async {
    _buffer.add(logData);

    if (_buffer.length >= bufferSize) {
      await _flushBuffer();
    }
  }

  Future<void> _flushBuffer() async {
    return _lock.synchronized(() async {
      if (_buffer.isEmpty) return;

      final jsonString = '${_buffer.map(jsonEncode).join('\n')}\n';
      _buffer.clear();

      final directory = await getApplicationDocumentsDirectory();
      final logFile = File('${directory.path}/$fileName');

      // We used a buffer for minimize the losses during the async IO operation
      // ignore: avoid_slow_async_io
      final logFileExists = await logFile.exists();
      if (!logFileExists) {
        await logFile.create();
      }

      await logFile.writeAsString(jsonString, mode: FileMode.append);
    });
  }

  static Future<Iterable<Map<String, Object?>>> getAllLogs(String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    final logFile = File('${directory.path}/$filename');

    // ignore: avoid_slow_async_io
    final logFileExists = await logFile.exists();
    if (!logFileExists) {
      return [];
    }

    final logsAsString = await logFile.readAsString();
    final logLines = logsAsString.split('\n');

    return logLines.where((line) => line.isNotEmpty).map((line) => jsonDecode(line) as Map<String, Object?>);
  }
}
