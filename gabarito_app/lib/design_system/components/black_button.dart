import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../motion/press_effect.dart';
import '../theme/app_tokens_extension.dart';

class BlackButton extends StatelessWidget {
  const BlackButton({super.key, required this.label, required this.onPressed, this.minWidth = 160});

  final String label;
  final VoidCallback onPressed;
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final styleToken = t.typography['h4Bold'];
    final TextStyle textStyle = GoogleFonts.getFont(t.fontFamily).copyWith(
      color: t.brand,
      fontSize: styleToken?.fontSize ?? 18,
      fontWeight: styleToken?.fontWeight ?? FontWeight.w800,
      height: styleToken?.height ?? 1.01,
      letterSpacing: styleToken?.letterSpacing ?? -0.36,
    );

    return PressEffect(
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: minWidth),
        child: TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: t.spacingLg + t.spacingSm, vertical: t.spacingSm)),
            backgroundColor: WidgetStateProperty.all(t.textInvertedStrong),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            ),
            overlayColor: WidgetStateProperty.all(Colors.transparent),
          ),
          child: Text(label, style: textStyle.copyWith(fontSize: 14, height: 1.5)),
        ),
      ),
    );
  }
}


