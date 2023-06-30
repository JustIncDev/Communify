import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../features/connect/presentation/connect_screen.dart';
import '../../../features/home/presentation/home_screen.dart';
import '../../../features/splash/presentation/splash_screen.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_state.dart';

/// Main point of the application navigation
class AppRouter {
  final GoRouter _goRouter;

  static GlobalKey<NavigatorState>? _navigatorKey;

  static final AppRouter _router = AppRouter._();

  AppRouter._()
      : _goRouter = GoRouter(
          navigatorKey: _navigatorKey,
          debugLogDiagnostics: true,
          routes: [
            GoRoute(
              path: '/',
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: const SplashScreen(),
              ),
            ),
            GoRoute(
              path: '/login',
              pageBuilder: (context, state) => CustomTransitionPage<void>(
                child: const ConnectScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0, 1);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;

                  final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  final offsetAnimation = animation.drive(tween);

                  return SlideTransition(position: offsetAnimation, child: child);
                },
              ),
            ),
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) => CustomTransitionPage<void>(
                child: const HomeScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0, 1);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;

                  final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  final offsetAnimation = animation.drive(tween);

                  return SlideTransition(position: offsetAnimation, child: child);
                },
              ),
            ),
          ],
        );

  /// Singleton instance of [AppRouter]
  factory AppRouter.instance({GlobalKey<NavigatorState>? key}) {
    _navigatorKey = key;
    return _router;
  }

  /// Methods that wrap the methods of GoRouter
  String? get currentPath => _goRouter.routerDelegate.currentConfiguration.fullPath;

  /// Router config
  RouterConfig<Object>? get routerConfig => _goRouter;

  void go(String path) => _goRouter.go(path);
}
