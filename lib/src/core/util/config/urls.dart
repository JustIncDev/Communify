import 'app_config.dart';
import 'environment/environment.dart';

/// Server urls.
abstract final class Url {
  /// TRest url.
  static String get testUrl => '';

  /// Prod url.
  static String get prodUrl => '';

  /// Dev url.
  static String get devUrl => '';

  /// Base url.
  static String? get baseUrl => Environment<AppConfig>.instance().config.url;
}
