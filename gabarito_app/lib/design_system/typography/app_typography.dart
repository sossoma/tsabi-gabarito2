import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  const AppTypography._();

  static TextTheme textTheme(TextTheme base) {
    final TextTheme nunito = GoogleFonts.nunitoTextTheme(base);
    return nunito.copyWith(
      headlineSmall: nunito.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
      titleLarge: nunito.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      bodyMedium: nunito.bodyMedium?.copyWith(height: 1.4),
    );
  }
}


