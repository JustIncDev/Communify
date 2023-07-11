import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../core/application/bloc/auth/auth_bloc.dart';
import '../../../core/application/bloc/auth/auth_state.dart';
import '../../../core/application/bloc/bloc.dart';
import '../../../core/application/bloc/global_bloc_provider.dart';
import '../../../core/application/common/widgets/primary_button.dart';
import '../../../core/application/navigation/router.dart';
import '../../../core/util/assets/colors/color_scheme.dart';
import '../../../core/util/assets/colors/colors.dart';
import '../../../core/util/assets/text/text_extention.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ValueNotifier<bool> _showBody = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final appColors = AppColorScheme.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, authState) {
        if (authState is AuthUnauthenticated) {
          Future.delayed(
            const Duration(seconds: 1),
            () {
              if (mounted) {
                _showBody.value = true;
              }
            },
          );
        }
        if (authState is AuthAuthenticated) {
          Future.delayed(
            const Duration(seconds: 1),
            () {
              if (mounted) {
                AppRouter.instance().go('/home');
              }
            },
          );
        }
      },
      child: Scaffold(
        backgroundColor: appColors.primary,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Image.asset(AppAssets.images.communify.path),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _showBody,
              builder: (context, showBody, child) {
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 2000),
                  bottom: showBody ? 150 : -1000, // You can adjust these values
                  left: 0,
                  right: 0,
                  child: const _LoginBodyWidget(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginBodyWidget extends StatefulWidget {
  const _LoginBodyWidget({
    super.key,
  });

  @override
  State<_LoginBodyWidget> createState() => _LoginBodyWidgetState();
}

class _LoginBodyWidgetState extends State<_LoginBodyWidget> {
  @override
  Widget build(BuildContext context) {
    final textTheme =
        Theme.of(context).extension<AppTextTheme>() ?? AppTextTheme.base();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: S.current.communities,
                style: textTheme.regular15.copyWith(
                  fontSize: 14,
                  fontFamily: 'Karla',
                  fontWeight: FontWeight.w400,
                  color: AppColors.whiteSmoke.value,
                ),
              ),
              const TextSpan(text: ' '),
              TextSpan(
                text: 'Blockchain',
                style: textTheme.regular15.copyWith(
                  fontSize: 14,
                  fontFamily: 'Karla',
                  fontWeight: FontWeight.w400,
                  color: AppColors.pumpkin.value,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 26),
        PrimaryButton(
          onPressed: _onLoginButtonPressed,
          child: Text(
            'SIGN UP / LOGIN',
            style: textTheme.bold12.copyWith(
                fontWeight: FontWeight.w800,
                fontFamily: 'Montserrat',
                color: AppColors.pumpkin.value),
          ),
        ),
      ],
    );
  }

  void _onLoginButtonPressed() {
    context.go('/login');
  }
}
