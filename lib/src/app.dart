import 'package:flutter/material.dart';

import 'assets/themes/theme_data.dart';
import 'config/app_config.dart';
import 'config/environment/environment.dart';
import 'global/common/service/theme/theme_service.dart';
import 'global/common/widgets/debug/debug_route_widget.dart';
import 'global/common/widgets/di_scope/di_scope.dart';
import 'global/di/app_scope.dart';
import 'global/storage/config_storage/config_storage_impl.dart';

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
      child: AnimatedBuilder(
        animation: _themeService,
        builder: (context, child) {
          return MaterialApp.router(
            theme: AppThemeData.lightTheme,
            darkTheme: AppThemeData.darkTheme,
            themeMode: _themeService.currentThemeMode,
            routerConfig: _scope.router.routerConfig,
            builder: (_, child) => DebugPanelRouteWidget(
              appScope: _scope,
              child: child,
            ),
          );
        },
      ),
    );
  }

  void _rebuildApplication() {
    setState(() {
      _scope = widget.appScope..applicationRebuilder = _rebuildApplication;
    });
  }
}
