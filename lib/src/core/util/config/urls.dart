import 'app_config.dart';
import 'environment/environment.dart';

/// Server urls.
abstract final class Url {
  /// TRest url.
  static String get testUrl => const String.fromEnvironment('SERVER_URL');

  /// Prod url.
  static String get prodUrl => const String.fromEnvironment('SERVER_URL');

  /// Dev url.
  static String get devUrl => const String.fromEnvironment('SERVER_URL');

  /// Base url.
  static String? get baseUrl => Environment<AppConfig>.instance().config.url;
}
