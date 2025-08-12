import 'package:flutter/material.dart';
import '../motion/press_effect.dart';
import '../theme/app_tokens_extension.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key, required this.label, required this.onPressed, this.width = 331, this.height = 60});

  final String label;
  final VoidCallback? onPressed;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final Color textColor = t.semantics.colors['typographyBrand'] ?? t.brand;
    final Color borderColor = t.semantics.colors['strokeBrand'] ?? t.brand;
    final Color pressedBg = t.semantics.colors['fillBrandWeak'] ?? t.brand.withValues(alpha: 0.05);

    final styleToken = t.typography['h4Bold'];
    final TextStyle textStyle = GoogleFonts.getFont(t.fontFamily).copyWith(
      color: textColor,
      fontSize: styleToken?.fontSize ?? 18,
      fontWeight: styleToken?.fontWeight ?? FontWeight.w800,
      height: styleToken?.height ?? 1.01,
      letterSpacing: styleToken?.letterSpacing ?? -0.36,
    );

    return PressEffect(
      child: SizedBox(
        width: width,
        height: height,
        child: TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(horizontal: t.spacingLg, vertical: t.spacingMd),
            ),
            fixedSize: WidgetStateProperty.all(Size(width, height)),
            minimumSize: WidgetStateProperty.all(Size(width, height)),
            backgroundColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) => states.contains(WidgetState.pressed) ? pressedBg : Colors.transparent,
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(t.radiusPill)),
            ),
            side: WidgetStateProperty.all(BorderSide(width: 2, color: borderColor)),
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            foregroundColor: WidgetStateProperty.all(textColor),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
          child: Center(child: Text(label, style: textStyle)),
        ),
      ),
    );
  }
}


