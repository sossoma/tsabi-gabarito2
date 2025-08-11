import 'package:flutter/animation.dart';

class MotionTokens {
  const MotionTokens._();

  // Durations (ms)
  static const Duration durationXs = Duration(milliseconds: 120);
  static const Duration durationSm = Duration(milliseconds: 180);
  static const Duration durationMd = Duration(milliseconds: 240);
  static const Duration durationLg = Duration(milliseconds: 320);

  // Curves aligned with iOS feel
  static const Curve easeInOut = Curves.easeInOutCubic;
  static const Curve emphasized = Curves.easeInOutCubicEmphasized;
}


