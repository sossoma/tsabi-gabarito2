import 'package:flutter/material.dart';
import '../motion/press_effect.dart';
import '../theme/app_tokens_extension.dart';
import 'package:google_fonts/google_fonts.dart';
import '../effects/inner_shadow.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.label, required this.onPressed, this.width = 331, this.height = 60, this.child});

  final String label;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;

    final styleToken = t.typography['h4Bold'];
    final TextStyle textStyle = GoogleFonts.getFont(
      t.fontFamily,
      textStyle: const TextStyle(),
    ).copyWith(
      color: t.textInvertedStrong,
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
            const Positioned.fill(child: SizedBox()),
            Positioned.fill(
              child: InnerShadow(
                color: t.buttonInnerShadow.color,
                blur: t.buttonInnerShadow.blur,
                offset: Offset(t.buttonInnerShadow.x, t.buttonInnerShadow.y),
                radius: t.radiusPill,
                spread: t.buttonInnerShadow.spread,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: _PressedBuilder(
                width: width,
                height: height,
                radius: 30.24,
                colorDefault: t.brand,
                colorPressed: t.brandPressed,
                onTap: onPressed,
                child: Center(child: child ?? Text(label, style: textStyle)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PressedBuilder extends StatelessWidget {
  const _PressedBuilder({
    required this.width,
    required this.height,
    required this.radius,
    required this.colorDefault,
    required this.colorPressed,
    required this.child,
    required this.onTap,
  });

  final double width;
  final double height;
  final double radius;
  final Color colorDefault;
  final Color colorPressed;
  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onTap,
        style: ButtonStyle(
          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 33.62, vertical: 16)),
          fixedSize: WidgetStateProperty.all(Size(width, height)),
          minimumSize: WidgetStateProperty.all(Size(width, height)),
          backgroundColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) => states.contains(WidgetState.pressed) ? colorPressed : colorDefault,
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
          ),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          foregroundColor: WidgetStateProperty.all(Colors.transparent),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
        child: child,
      ),
    );
  }
}


