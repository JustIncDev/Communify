import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../assets/colors/color_scheme.dart';
import '../../../../assets/colors/colors.dart';
import '../../../../assets/text/text_extention.dart';
import '../../../../global/common/widgets/primary_button.dart';

class SplashLoginPage extends StatefulWidget {
  const SplashLoginPage({
    required this.onNext,
  });

  final VoidCallback onNext;

  @override
  _SplashLoginPageState createState() => _SplashLoginPageState();
}

class _SplashLoginPageState extends State<SplashLoginPage> {
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
          child: _LoginBodyWidget(
            onPressed: widget.onNext,
          ),
        ),
      ],
    );
  }
}

class _LoginBodyWidget extends StatefulWidget {
  const _LoginBodyWidget({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<_LoginBodyWidget> createState() => _LoginBodyWidgetState();
}

class _LoginBodyWidgetState extends State<_LoginBodyWidget> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>() ?? AppTextTheme.base();

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
          onPressed: widget.onPressed,
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
}
