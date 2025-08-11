import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../tokens/tokens.dart';
import 'app_tokens_extension.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData materialTheme(Brightness brightness, {DesignTokens? tokens}) {
    final DesignTokens t = tokens ?? DesignTokens.fallback();
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: t.brand,
      brightness: brightness,
    );
    return ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      textTheme: GoogleFonts.nunitoTextTheme(),
      extensions: <ThemeExtension<dynamic>>[TokensExtension(tokens: t)],
      appBarTheme: AppBarTheme(
        backgroundColor: t.bgSurface,
        foregroundColor: scheme.onSurface,
        centerTitle: true,
        elevation: 0,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(t.radiusPill)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),
    );
  }
}


