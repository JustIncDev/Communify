//ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// App text style.
enum AppTextStyle {
  regular15(TextStyle(fontSize: 15, height: 1.2, letterSpacing: -0.32)),
  regular20(TextStyle(fontSize: 20, height: 1.2, letterSpacing: -0.32)),

  medium15(TextStyle(fontSize: 15, height: 1.2, letterSpacing: -0.32, fontWeight: FontWeight.w500)),

  bold12(TextStyle(fontSize: 12, height: 1.2, letterSpacing: -0.32)),
  bold20(TextStyle(fontSize: 20, height: 1.2, letterSpacing: -0.32, fontWeight: FontWeight.w800)),
  bold30(TextStyle(fontSize: 30, height: 1.2, letterSpacing: -0.32, fontWeight: FontWeight.w800));

  final TextStyle value;

  const AppTextStyle(this.value);
}
