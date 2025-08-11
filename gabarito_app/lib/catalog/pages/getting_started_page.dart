import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../design_system/theme/app_tokens_extension.dart';
import '../../design_system/components/primary_button.dart';
import 'package:go_router/go_router.dart';

class GettingStartedPage extends StatelessWidget {
  const GettingStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final base = GoogleFonts.getFont(t.fontFamily);

    // Title style from tokens with spec (32, ExtraBold, 101%, -0.64)
    final h1 = t.typography['h1'];
    final TextStyle titleStyle = base.copyWith(
      fontSize: h1?.fontSize ?? 32,
      fontWeight: FontWeight.w800,
      height: 1.01,
      letterSpacing: -0.64,
      color: t.brand,
    );

    // Subtitle style from tokens, adjusted to (18, w600, 1.12, -0.36)
    final TextStyle subtitleStyle = base.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.12,
      letterSpacing: -0.36,
      color: t.textPrimary.withValues(alpha: 0.73),
    );

    return Scaffold(
      backgroundColor: t.bgCanvas,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(t.spacingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 329,
                      child: Text(
                        'Tire a foto de todas as páginas da sua prova inclusive da capa',
                        textAlign: TextAlign.center,
                        style: titleStyle,
                      ),
                    ),
                    SizedBox(height: t.spacingMd),
                    SizedBox(
                      width: 338,
                      child: Text(
                        'Vá para um ambiente iluminado e posicione sua câmera perfeitamente.',
                        textAlign: TextAlign.center,
                        style: subtitleStyle,
                      ),
                    ),
                    SizedBox(height: t.spacingLg),
                    // Illustration
                    Flexible(
                      child: Image.asset(
                        'assets/images/mobile.png',
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                      ),
                    ),
                    SizedBox(height: t.spacingLg),
                  ],
                ),
              ),
              PrimaryButton(label: 'Tirar Photos', onPressed: () => context.goNamed('page_take_photos')),
            ],
          ),
        ),
      ),
    );
  }
}


