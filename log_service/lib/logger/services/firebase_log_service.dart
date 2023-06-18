part of 'services.dart';

class FirebaseService implements LogServiceInterface {
  FirebaseService({
    this.enabled = true,
  });

  static late FirebaseService _instance;

  static FirebaseService get instance => _instance;

  late FirebaseAnalytics _analytics;
  late FirebaseCrashlytics _crashlytics;
  @override
  final bool enabled;

  FirebaseAnalytics get analytics => _analytics;

  FirebaseCrashlytics get crashlytics => _crashlytics;

  static Future<void> initApplication({bool enabled = true}) {
    _instance = FirebaseService(enabled: enabled);
    return _instance.init();
  }

  Future<void> init() => Firebase.initializeApp().then(
        (_) => Future.wait([
          _initAnalytics(),
          _initCrashlytics(),
        ]),
      );

  Future<void> _initAnalytics() async {
    _analytics = FirebaseAnalytics.instance;

    await _analytics.setAnalyticsCollectionEnabled(enabled);
  }

  Future<void> _initCrashlytics() async {
    _crashlytics = FirebaseCrashlytics.instance;

    await _crashlytics.setCrashlyticsCollectionEnabled(enabled);

    if (enabled) FlutterError.onError = _crashlytics.recordFlutterError;
  }

  Future<void> recordError(Object error, [StackTrace? stackTrace]) async {
    if (enabled) await _crashlytics.recordError(error, stackTrace);
  }

  @override
  void logError({
    required String message,
    required Object error,
    StackTrace? stackTrace,
    Map<String, Object>? additionalArgs,
  }) {
    recordError(error, stackTrace);
    _analytics.logEvent(
      name: 'Error',
      parameters: {
        'error': error,
        'additional_data': additionalArgs,
      },
    );
  }

  @override
  void logInfo({required Object message}) {}

  @override
  void logWarning({required Object message, StackTrace? stackTrace}) {}
}
