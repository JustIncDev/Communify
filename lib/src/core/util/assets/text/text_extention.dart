import 'package:flutter/material.dart';

import 'text_style.dart';

/// App text style scheme.
class AppTextTheme extends ThemeExtension<AppTextTheme> {
  /// Text style 15_400.
  final TextStyle regular15;

  /// Text style 20_400
  final TextStyle regular20;

  /// Text style 15_500.
  final TextStyle medium15;

  /// Text style 12_800
  final TextStyle bold12;

  /// Text style 20_800.
  final TextStyle bold20;

  /// Text style 30_800.
  final TextStyle bold30;

  AppTextTheme._({
    required this.regular15,
    required this.regular20,
    required this.medium15,
    required this.bold12,
    required this.bold20,
    required this.bold30,
  });

  /// Base app text theme.
  AppTextTheme.base()
      : regular15 = AppTextStyle.regular15.value,
        regular20 = AppTextStyle.regular20.value,
        medium15 = AppTextStyle.medium15.value,
        bold12 = AppTextStyle.bold12.value,
        bold20 = AppTextStyle.bold20.value,
        bold30 = AppTextStyle.bold30.value;

  @override
  ThemeExtension<AppTextTheme> lerp(
    ThemeExtension<AppTextTheme>? other,
    double t,
  ) {
    if (other is! AppTextTheme) {
      return this;
    }

    return copyWith(
      regular15: TextStyle.lerp(regular15, other.regular15, t),
      regular20: TextStyle.lerp(regular20, other.regular20, t),
      medium15: TextStyle.lerp(medium15, other.medium15, t),
      bold12: TextStyle.lerp(bold12, other.bold12, t),
      bold20: TextStyle.lerp(bold20, other.bold20, t),
      bold30: TextStyle.lerp(bold30, other.bold30, t),
    );
  }

  /// Return text theme for app from context
  static AppTextTheme of(BuildContext context) {
    return Theme.of(context).extension<AppTextTheme>() ?? _throwThemeExceptionFromFunc(context);
  }

  /// @nodoc
  AppTextTheme copyWith({
    TextStyle? regular15,
    TextStyle? regular20,
    TextStyle? medium15,
    TextStyle? bold12,
    TextStyle? bold20,
    TextStyle? bold30,
  }) {
    return AppTextTheme._(
      regular15: regular15 ?? this.regular15,
      regular20: regular20 ?? this.regular20,
      medium15: medium15 ?? this.medium15,
      bold12: bold12 ?? this.bold12,
      bold20: bold20 ?? this.bold20,
      bold30: bold30 ?? this.bold30,
    );
  }
}

Never _throwThemeExceptionFromFunc(BuildContext context) =>
    throw Exception("$AppTextTheme hasn't been found in $context");
