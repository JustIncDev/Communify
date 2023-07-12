import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:log_service/lib.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../util/config/app_config.dart';
import '../../util/config/environment/environment.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_state.dart';
import '../bloc/log_bloc_observer.dart';
import '../common/service/theme/theme_service.dart';
import '../common/service/theme/theme_service_impl.dart';
import '../navigation/router.dart';
import '../storage/theme_storage/theme_storage.dart';
import '../storage/theme_storage/theme_storage_impl.dart';

class AppScope implements IAppScope {
  static const _themeByDefault = ThemeMode.system;

  late final Dio _dio;
  late final IThemeService _themeService;
  late final AppRouter _router;
  late final AuthBloc _authBloc;

  static late final Alice _alice;

  @override
  late VoidCallback applicationRebuilder;

  @override
  Dio get dio => _dio;

  @override
  Alice get alice => _alice;

  @override
  IThemeService get themeService => _themeService;

  @override
  AppRouter get router => _router;

  @override
  AuthBloc get authBloc => _authBloc;

  late IThemeModeStorage _themeModeStorage;

  /// Create an instance [AppScope].
  AppScope() {
    /// List interceptor. Fill in as needed.
    final additionalInterceptors = <Interceptor>[];
    _dio = _initDio(additionalInterceptors);

    /// Global BLoCs initialization
    _authBloc = AuthBloc(
      authenticationRepository: AuthRepositoryImpl(_dio),
      profileRepository: ProfileRepositoryImpl(),
      initState: AuthInitial(),
    );

    /// Router initialization
    _router = AppRouter.instance(key: _alice.getNavigatorKey());
    _themeModeStorage = ThemeModeStorageImpl();
  }

  @override
  Future<void> initTheme() async {
    final theme =
        await ThemeModeStorageImpl().getThemeMode() ?? _themeByDefault;
    _themeService = ThemeServiceImpl(theme);
    _themeService.addListener(_onThemeModeChanged);
  }

  Dio _initDio(Iterable<Interceptor> additionalInterceptors) {
    const timeout = Duration(milliseconds: 30000);

    final dio = Dio();

    dio.options
      ..baseUrl = Environment<AppConfig>.instance().config.url
      ..connectTimeout = timeout
      ..receiveTimeout = timeout
      ..sendTimeout = timeout;

    /// Set up proxy
    final proxyUrl = Environment<AppConfig>.instance().config.proxyUrl;
    if (proxyUrl != null && proxyUrl.isNotEmpty) {
      dio.setProxy(CustomProxy.fromString(proxyUrl));
    }

    /// Set up interceptors
    dio.interceptors.addAll(additionalInterceptors);

    /// Set up log interceptor
    if (Environment<AppConfig>.instance().isDebug) {
      dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    }

    return dio;
  }

  Future<void> _onThemeModeChanged() async {
    await _themeModeStorage.saveThemeMode(mode: _themeService.currentThemeMode);
  }

  /// Initializes logging services
  static Future<void> _initLoggerServices() async {
    final config = Environment<AppConfig>.instance();

    final aliceLoggerService = AliceLoggerService(enabled: config.isDebug);
    _alice = aliceLoggerService.aliceInstance;

    await FirebaseService.initApplication(enabled: config.isRelease);

    LogServiceManager.init([
      aliceLoggerService,
      ConsoleLogService(enabled: config.isDebug),
      FileLogService(enabled: config.isDebug),
      FirebaseService.instance,
    ]);

    /// Sets up custom error handling for flutter errors
    LogServiceManager.setUpCustomFlutterErrorHandling();

    /// Sets up bloc observer for handling bloc changes
    Bloc.observer = LogBlocObserver(enabled: config.isDebug);
  }

  static Future<void> initServices() async {
    await _initLoggerServices();
    await Supabase.initialize(
      url: const String.fromEnvironment('PROJECT_URL'),
      anonKey: const String.fromEnvironment('ANON_KEY'),
    );
  }
}

/// App dependencies.
abstract class IAppScope {
  /// Http client.
  Dio get dio;

  /// Alice client for displaying debug panel
  Alice get alice;

  /// Callback to rebuild the whole application.
  VoidCallback get applicationRebuilder;

  /// Class that coordinates navigation for the whole app.
  AppRouter get router;

  /// A service that stores and retrieves app theme mode.
  IThemeService get themeService;

  /// Authentication bloc
  AuthBloc get authBloc;

  /// Init theme service with theme from storage or default value
  Future<void> initTheme();
}
