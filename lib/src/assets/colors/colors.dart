//ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// App color palette.
///
/// http://www.color-blindness.com/color-name-hue/.

enum AppColors {
  blueCharcoal(Color(0xFF23272B)),
  pumpkin(Color(0xFFFE8717)),
  whiteSmoke(Color(0xFFF2F2F2)),
  fireBrick(Color(0xFFB3261E)),
  gainsboro(Color(0xFFD9D9D9)),
  grape(Color(0xCC49454F)),
  swamp(Color(0xFF1A1D1D)),
  darkSlate(Color(0xFF475050)),
  suvaGrey(Color(0xFF8F8F8F)),
  black(Color(0xFF000000)),
  summerSky(Color(0xFF3C8AD9)),
  grey(Color(0xFF797979));

  final Color value;

  const AppColors(this.value);
}
