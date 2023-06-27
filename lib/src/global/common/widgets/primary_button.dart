import 'package:flutter/material.dart';

import '../../../assets/colors/colors.dart';
import 'base_container.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    required this.onPressed,
    required this.child,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;

  @override
  _LoginButtonWidgetState createState() => _LoginButtonWidgetState();
}

class _LoginButtonWidgetState extends State<PrimaryButton> {
  final ValueNotifier<bool> _isPressed = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        _isPressed.value = true;
      },
      onTapCancel: () {
        _isPressed.value = false;
      },
      onTap: () {
        _isPressed.value = false;
        widget.onPressed();
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: _isPressed,
        builder: (context, isPressed, child) {
          return BaseContainerWidget(
            padding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 33,
            ),
            boxShadow: isPressed
                ? const [
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
                  ]
                : null,
            contentGradientColors: isPressed
                ? [
                    AppColors.blueCharcoal.value,
                    AppColors.blueCharcoal.value,
                    AppColors.pumpkin.value,
                  ]
                : [
                    AppColors.blueCharcoal.value,
                    AppColors.blueCharcoal.value,
                    AppColors.grey.value,
                  ],
            contentGradientStops: const [0.0, 0.65, 1.0],
            borderGradientColors: isPressed
                ? [Colors.blue, Colors.blueAccent]
                : [AppColors.suvaGrey.value, AppColors.pumpkin.value],
            child: widget.child,
          );
        },
      ),
    );
  }
}
