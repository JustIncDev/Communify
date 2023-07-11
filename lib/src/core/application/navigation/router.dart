import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../features/connect/presentation/connect_screen.dart';
import '../../../features/home/presentation/home_screen.dart';
import '../../../features/registration/presentation/pages/choose_network_page.dart';
import '../../../features/registration/presentation/pages/complete_profile_data_page.dart';
import '../../../features/registration/presentation/pages/complete_profile_social_links_page.dart';
import '../../../features/registration/presentation/pages/group_name_page.dart';
import '../../../features/registration/presentation/pages/group_theme_page.dart';
import '../../../features/registration/presentation/pages/profile_details_page.dart';
import '../../../features/registration/presentation/pages/successful_page.dart';
import '../../../features/registration/presentation/registration_screen.dart';
import '../../../features/splash/presentation/splash_screen.dart';
import '../bloc/bloc.dart';

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
              pageBuilder: (context, state) {
                final blocFactory = Provider.of<BlocFactory>(context);
                return CustomTransitionPage<void>(
                  child: BlocProvider(
                    create: (context) => blocFactory.createConnectBloc(),
                    lazy: false,
                    child: const ConnectScreen(),
                  ),
                  transitionsBuilder: _buildTransition,
                );
              },
            ),
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) => const CustomTransitionPage<void>(
                child: HomeScreen(),
                transitionsBuilder: _buildTransition,
              ),
            ),
            GoRoute(
              path: '/sign-up',
              pageBuilder: (context, state) {
                return const CustomTransitionPage<void>(
                  transitionDuration: Duration.zero,
                  child: RegistrationScreen(),
                  transitionsBuilder: _buildTransition,
                );
              },
              routes: [
                GoRoute(
                  path: 'choose-network',
                  pageBuilder: (context, state) =>
                      const CustomTransitionPage<void>(
                    child: ChooseNetworkPage(),
                    transitionsBuilder: _buildTransition,
                  ),
                ),
                GoRoute(
                  path: 'credentials',
                  pageBuilder: (context, state) => CustomTransitionPage<void>(
                    child: ProfileDetailsPage(
                      createGroup: state.extra as bool,
                    ),
                    transitionsBuilder: _buildTransition,
                  ),
                ),
                GoRoute(
                  path: 'group/choose-theme',
                  pageBuilder: (context, state) =>
                      const CustomTransitionPage<void>(
                    child: GroupThemePage(),
                    transitionsBuilder: _buildTransition,
                  ),
                ),
                GoRoute(
                  path: 'group/choose-name',
                  pageBuilder: (context, state) => CustomTransitionPage<void>(
                    child: GroupNamePage(
                      groupTheme: state.extra as String?,
                    ),
                    transitionsBuilder: _buildTransition,
                  ),
                ),
                GoRoute(
                  path: 'success',
                  pageBuilder: (context, state) => CustomTransitionPage<void>(
                    child: SuccessfulPage(
                      groupName: state.extra as String?,
                    ),
                    transitionsBuilder: _buildTransition,
                  ),
                ),
                GoRoute(
                  path: 'complete-profile/first',
                  pageBuilder: (context, state) =>
                      const CustomTransitionPage<void>(
                    child: CompleteProfileDataPage(),
                    transitionsBuilder: _buildTransition,
                  ),
                ),
                GoRoute(
                  path: 'complete-profile/second',
                  pageBuilder: (context, state) =>
                      const CustomTransitionPage<void>(
                    child: CompleteProfileSocialLinksPage(),
                    transitionsBuilder: _buildTransition,
                  ),
                ),
              ],
            ),
          ],
        );

  /// Singleton instance of [AppRouter]
  factory AppRouter.instance({GlobalKey<NavigatorState>? key}) {
    _navigatorKey = key;
    return _router;
  }

  /// Methods that wrap the methods of GoRouter
  String? get currentPath =>
      _goRouter.routerDelegate.currentConfiguration.fullPath;

  /// Router config
  RouterConfig<Object>? get routerConfig => _goRouter;

  void go(String path, {Object? extra}) => _goRouter.go(path, extra: extra);
}

Widget _buildTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  const begin = Offset(0, 1);
  const end = Offset.zero;
  const curve = Curves.easeInOut;

  final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  final offsetAnimation = animation.drive(tween);

  return SlideTransition(position: offsetAnimation, child: child);
}
