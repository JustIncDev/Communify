import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../util/assets/colors/colors.dart';
import 'gradient/gradient_box_border.dart';

class BaseContainerWidget extends StatelessWidget {
  const BaseContainerWidget({
    required this.child,
    required this.padding,
    this.borderWidth = 1.0,
    this.contentGradientColors,
    this.contentGradientStops,
    this.borderGradientColors,
    this.borderGradientStops,
    this.boxShadow,
    super.key,
  });

  final Widget child;
  final EdgeInsets padding;
  final double borderWidth;
  final List<Color>? contentGradientColors;
  final List<double>? contentGradientStops;
  final List<Color>? borderGradientColors;
  final List<double>? borderGradientStops;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.blueCharcoal.value,
        gradient: contentGradientColors != null
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                transform: const GradientRotation(math.pi / 5),
                stops: contentGradientStops ?? const [0.0, 0.65, 1.0],
                colors: contentGradientColors ??
                    [
                      AppColors.blueCharcoal.value.withOpacity(0.35),
                      AppColors.blueCharcoal.value.withOpacity(0.35),
                      AppColors.gainsboro.value.withOpacity(0),
                    ],
              )
            : null,
        borderRadius: BorderRadius.circular(25),
        border: GradientBoxBorder(
          gradient: LinearGradient(
            colors: borderGradientColors ?? [AppColors.suvaGrey.value, AppColors.pumpkin.value],
            stops: borderGradientStops,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          width: borderWidth,
        ),
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
