import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../design_system/theme/app_tokens_extension.dart';
import '../../design_system/components/alternative_button.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final base = GoogleFonts.getFont(t.fontFamily);

    final TextStyle subtitle = base.copyWith(
      color: t.textPrimary,
      fontSize: (t.typography['h2']?.fontSize) ?? 24,
      fontWeight: (t.typography['h2']?.fontWeight) ?? FontWeight.w800,
      height: (t.typography['h2']?.height) ?? 1.20,
      letterSpacing: (t.typography['h2']?.letterSpacing) ?? -0.48,
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/images/splash-screen.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: t.spacingLg,
                right: t.spacingLg,
                bottom: t.spacingLg + t.spacingXs, // 24 + 8 = 32
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Spacer(),
                  // Logo image
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.centerLeft,
                          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 338,
                        child: Text(
                          'O gerador de  gabarito extra oficial de qualquer prova de forma rápida e precisa',
                          style: subtitle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: t.spacingLg + t.spacingSm),
                  // CTA Button
                  AlternativeButton(
                    width: double.infinity,
                    label: 'Pegue seu gabarito',
                    onPressed: () => context.goNamed('page_login'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


