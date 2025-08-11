import 'package:flutter/material.dart';
import '../motion/press_effect.dart';
import '../theme/app_tokens_extension.dart';

class IconCircleButton extends StatelessWidget {
  const IconCircleButton({super.key, required this.assetPath, this.onTap});

  final String assetPath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return PressEffect(
      child: InkWell(
        borderRadius: BorderRadius.circular(9999),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(7),
          decoration: ShapeDecoration(
            color: t.brand,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
          ),
          child: Image.asset(assetPath, width: 17.5, height: 17.5, color: t.textInvertedStrong),
        ),
      ),
    );
  }
}


