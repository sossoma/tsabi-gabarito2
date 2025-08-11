import 'package:flutter/material.dart';
import '../motion/press_effect.dart';
import '../theme/app_tokens_extension.dart';
import 'package:google_fonts/google_fonts.dart';
import '../effects/inner_shadow.dart';

class AlternativeButton extends StatelessWidget {
  const AlternativeButton({super.key, required this.label, required this.onPressed, this.width = 331, this.height = 60});

  final String label;
  final VoidCallback onPressed;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;

    final Color bgDefault = t.semantics.colors['fillPrimaryStrong'] ?? Colors.white;
    final Color bgPressed = t.semantics.colors['fillPrimaryPressed'] ?? Colors.white.withValues(alpha: 0.70);
    final Color textColor = t.textInvertedStrong;

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
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: InnerShadow(
                color: t.buttonInnerShadow.color,
                blur: t.buttonInnerShadow.blur,
                offset: Offset(t.buttonInnerShadow.x, t.buttonInnerShadow.y),
                radius: t.radiusPill,
                spread: t.buttonInnerShadow.spread,
              ),
            ),
            Positioned.fill(
              child: TextButton(
                onPressed: onPressed,
                style: ButtonStyle(
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(horizontal: t.spacingLg, vertical: t.spacingMd),
            ),
                  fixedSize: const WidgetStatePropertyAll(Size.fromHeight(60)),
                  minimumSize: const WidgetStatePropertyAll(Size(0, 60)),
            backgroundColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) => states.contains(WidgetState.pressed) ? bgPressed : bgDefault,
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(t.radiusPill)),
            ),
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            foregroundColor: WidgetStateProperty.all(textColor),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
                ),
                child: Center(child: Text(label, style: textStyle)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


