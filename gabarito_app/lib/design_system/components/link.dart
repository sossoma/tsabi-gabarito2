import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_tokens_extension.dart';

class LinkText extends StatelessWidget {
  const LinkText({super.key, required this.text, required this.onTap, this.textAlign});

  final String text;
  final VoidCallback onTap;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final base = GoogleFonts.getFont(t.fontFamily);
    final TextStyle style = base.copyWith(
      color: t.textPrimary.withValues(alpha: 0.70),
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.30,
      letterSpacing: -0.32,
      decoration: TextDecoration.underline,
      decorationColor: t.textPrimary.withValues(alpha: 0.70),
    );
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Text(text, textAlign: textAlign ?? TextAlign.center, style: style),
    );
  }
}


