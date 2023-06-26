import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../assets/colors/color_scheme.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({
    this.onNext,
  });

  final VoidCallback? onNext;

  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  bool _showBody = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        Future.delayed(
          const Duration(seconds: 1),
          () {
            setState(() {
              _showBody = true;
            });
            if (widget.onNext != null) widget.onNext!();
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appColors = AppColorScheme.of(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: Image.asset(AppAssets.images.communify.path),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 2000),
          bottom: _showBody ? 150 : -1000, // You can adjust these values
          left: 0,
          right: 0,
          child: const _LoginBodyWidget(),
        ),
      ],
    );
  }
}

class _LoginBodyWidget extends StatefulWidget {
  const _LoginBodyWidget({super.key});

  @override
  State<_LoginBodyWidget> createState() => _LoginBodyWidgetState();
}

class _LoginBodyWidgetState extends State<_LoginBodyWidget> {
  @override
  Widget build(BuildContext context) {
    final appColors = AppColorScheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: S.current.communities,
                style: TextStyle(
                  color: appColors.surface,
                  fontSize: 12,
                  fontFamily: 'Karla',
                  fontWeight: FontWeight.w400,
                  height: 21,
                  letterSpacing: -0.32,
                ),
              ),
              const TextSpan(text: ' '),
              TextSpan(
                text: 'Blockchain',
                style: TextStyle(
                  color: appColors.secondary,
                  fontSize: 12,
                  fontFamily: 'Karla',
                  fontWeight: FontWeight.w400,
                  height: 21,
                  letterSpacing: -0.32,
                ),
              ),
            ],
          ),
        ),
        const _LoginButton(),
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = AppColorScheme.of(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 167, // Slightly larger than the button
          height: 47, // Slightly larger than the button
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28), // Keep in sync with button's borderRadius
            gradient: LinearGradient(
              colors: [
                const Color(0xFF475050).withOpacity(0.6),
                const Color(0xFF18B2DE).withOpacity(0.6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFFFFFFF),
                blurRadius: 0.95,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Color(0xFFFFFFFF),
                blurRadius: 1.91,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Color(0xFFFFFFFF),
                blurRadius: 6.68,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Color(0xFFFFFFFF),
                blurRadius: 22.90,
                spreadRadius: 0,
              )
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF23272B), // Background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 33),
            side: const BorderSide(
              width: 1,
            ),
          ),
          child: Text(
            'SIGN UP / LOGIN',
            style: TextStyle(
              color: appColors.secondary, // Change this color to your preference
              fontSize: 12,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w800,
              letterSpacing: -0.32,
            ),
          ),
        ),
      ],
    );
  }
}
