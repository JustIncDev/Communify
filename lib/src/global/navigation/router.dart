import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/registration/presentation/registration_screen.dart';
import '../../features/registration/presentation/pages/splash_login_page.dart';

/// Main point of the application navigation
class AppRouter {
  final GoRouter _goRouter;

  static GlobalKey<NavigatorState>? _navigatorKey;

  static final AppRouter _router = AppRouter._();

  AppRouter._()
      : _goRouter = GoRouter(
          navigatorKey: _navigatorKey,
          routes: [
            GoRoute(
              path: '/',
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: const RegistrationScreen(),
              ),
            ),
            // GoRoute(
            //   path: '/splash',
            //   pageBuilder: (context, state) => MaterialPage<void>(
            //     key: state.pageKey,
            //     child: SplashScreen(),
            //   ),
            // )
          ],
        );

  /// Singleton instance of [AppRouter]
  factory AppRouter.instance({GlobalKey<NavigatorState>? key}) {
    _navigatorKey = key;
    return _router;
  }

  /// Methods that wrap the methods of GoRouter
  String? get currentPath => _goRouter.location;

  /// Router config
  RouterConfig<Object>? get routerConfig => _goRouter;

  void go(String path) => _goRouter.go(path);
}
