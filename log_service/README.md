# Logger Service Package with Alice

This logger service package is designed to simplify logging in your Flutter applications by providing a flexible and easy-to-use interface for sending logs to various services that implement the `LogServiceInterface`. Additionally, this package comes with the debugger tool, Alice, which offers an interactive and feature-rich UI for monitoring and inspecting network traffic.

## Features

- A unified `LogServiceInterface` for logging messages and errors with multiple logging services.
- Support for custom log services that implement the `LogServiceInterface`.
- Integration with Alice for network monitoring, logging, and inspection.
- Configuration for enabling or disabling specific logging services.

## Getting started

To get started with the logger service package, follow these steps:

1. Add the package to your `pubspec.yaml` file:

```yaml
dependencies:
  logger_service: link_to_the_package
```

2. Import the package in your code:

```dart
import 'package:logger_service/logger_service.dart';
```

3. Configure and initialize the logger services:

```dart
Future<void> initLoggerServices() async {
  final alice = Alice();

  LogServiceManager.init([
    AliceLoggerService(alice, enabled: !kReleaseMode),
    ConsoleLogService(enabled: !kReleaseMode),
    CustomLogService(enabled: true),
    // Add other log services that implement LogServiceInterface
  ]);

  /// Sets up custom error handling for Flutter errors
  LogServiceManager.setUpCustomFlutterErrorHandling();
}
```

4. Use the logger service in your application:

```dart
logger.logInfo(message: 'This is an info message.');
logger.logWarning(message: 'This is a warning message.');
logger.logError(message: 'This is an error message.', error: someError);
```

5. Set up Alice for network inspection and monitoring:

```dart
final alice = Alice();
final dio = Dio()..interceptors.add(alice.getDioInterceptor());
```

6. Add `navigatorKey` to the `MaterialApp`

```dart
navigatorKey: initializer.alice.getNavigatorKey(),
```

7. Add `DebugControllerMixin` and `DebugPanelMixin` to the base class and initialize debug panel

```dart
 @override
void initState() {
  super.initState();
  initDebugPanelOverlay(
    context,
    shareLogs,
        () => openDebugServices(Provider.of<Initializer>(context, listen: false).alice),
  );
}
```

## Creating a Custom Log Service

To create a custom log service for your logger service package, follow these steps:

1. Implement the `LogServiceInterface` in your custom log service class:

```dart
class CustomLogService implements LogService {
  @override
  final bool enabled;

  CustomLogService({this.enabled = true});

  @override
  void logInfo({required String message, Object? error, StackTrace? stackTrace}) {}

// Implement other log methods...
}
```

2. Add the `CustomLogService` to the list of log services during logger service package initialization:
```dart
LogServiceManager.init([
  AliceLoggerService(alice, enabled: !kReleaseMode),
  ConsoleLogService(enabled: !kReleaseMode),
  CustomLogService(enabled: true),
  // Add other log services that implement LogServiceInterface
]);
```

3. Use the logger service package as usual. Your custom log service will now be used alongside the other log services:
```dart
logger.logInfo(message: 'This is an info message.');
logger.logWarning(message: 'This is a warning message.');
logger.logError(message: 'This is an error message.', error: someError);
```

## Additional information

Welcome to contribute ideas, suggestions, and improvements. You can edit the package, submit pull requests, or simply share your thoughts on how to make it better.
If you have any suggestions or improvements, feel free to contribute to the package's repository, open issues for discussion, or even contact the maintainers directly.
