import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';
import 'core/application/bloc/auth/auth_bloc.dart';
import 'core/application/bloc/auth/auth_event.dart';
import 'core/application/bloc/auth/auth_state.dart';
import 'core/application/bloc/bloc.dart';
import 'core/application/bloc/global_bloc_provider.dart';
import 'core/application/common/service/theme/theme_service.dart';
import 'core/application/common/widgets/debug/debug_route_widget.dart';
import 'core/application/common/widgets/di_scope/di_scope.dart';
import 'core/application/di/app_scope.dart';
import 'core/application/storage/config_storage/config_storage_impl.dart';
import 'core/util/assets/themes/theme_data.dart';
import 'core/util/config/app_config.dart';
import 'core/util/config/environment/environment.dart';

/// App widget.
class CommunifyApp extends StatefulWidget {
  /// Scope of dependencies which need through all app's life.
  final AppScope appScope;

  /// Create an instance App.
  const CommunifyApp(this.appScope, {Key? key}) : super(key: key);

  @override
  _CommunifyAppState createState() => _CommunifyAppState();
}

class _CommunifyAppState extends State<CommunifyApp> {
  late IAppScope _scope;
  late IThemeService _themeService;
  late final GlobalKey providerKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _scope = widget.appScope..applicationRebuilder = _rebuildApplication;
    _themeService = _scope.themeService;

    final configStorage = ConfigSettingsStorageImpl();
    final environment = Environment<AppConfig>.instance();
    if (!environment.isRelease) {
      environment.refreshConfigProxy(configStorage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DiScope<IAppScope>(
      key: ObjectKey(_scope),
      factory: () {
        return _scope;
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (_) => _scope.authBloc..add(AppStarted()),
          ),
        ],
        child: AnimatedBuilder(
          animation: _themeService,
          builder: (context, child) {
            return Provider<BlocFactory>(
              key: providerKey,
              create: (ctx) => BlocFactory(_scope.dio),
              child: MaterialApp.router(
                theme: AppThemeData.lightTheme,
                darkTheme: AppThemeData.darkTheme,
                themeMode: _themeService.currentThemeMode,
                routerConfig: _scope.router.routerConfig,
                builder: (_, child) => GlobalBlocProvider(
                  child: DebugPanelRouteWidget(
                    appScope: _scope,
                    child: child,
                  ),
                ),
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  S.delegate,
                ],
                supportedLocales: const [
                  Locale('en'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _rebuildApplication() {
    setState(() {
      _scope = widget.appScope..applicationRebuilder = _rebuildApplication;
    });
  }
}
