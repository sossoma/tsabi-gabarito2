import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_tokens_extension.dart';

enum BrandBadgeVariant { brandStrong, brandWeak }
enum BrandBadgeSize { small, large }

class BrandBadge extends StatelessWidget {
  const BrandBadge({
    super.key,
    required this.text,
    this.variant = BrandBadgeVariant.brandStrong,
    this.fullWidth = false,
    this.size = BrandBadgeSize.small,
  });

  final String text;
  final BrandBadgeVariant variant;
  final bool fullWidth;
  final BrandBadgeSize size;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final Color fill = variant == BrandBadgeVariant.brandStrong
        ? (t.semantics.colors['fillBrandAlternate'] ?? t.brand)
        : (t.semantics.colors['fillBrandWeak'] ?? t.brand.withValues(alpha: 0.05));
    final Color border = t.semantics.colors['strokeBrandWeak'] ?? t.brand.withValues(alpha: 0.30);
    final Color textColor = variant == BrandBadgeVariant.brandStrong
        ? t.textInvertedStrong
        : (t.semantics.colors['typographyBrand'] ?? t.brand);

    final bool isSmall = size == BrandBadgeSize.small;
    final TextStyle style = isSmall
        ? GoogleFonts.getFont(t.fontFamily).copyWith(
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            height: 1.30,
            letterSpacing: 0.30,
          )
        : GoogleFonts.getFont(t.fontFamily).copyWith(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 1.20,
            letterSpacing: -0.32,
          );

    final double horizontalPadding = context.tokens.spacingMd / 2; // 24 total (12 each side)
    return Container(
      width: fullWidth ? double.infinity : null,
      height: isSmall ? 30.5 : 32,
      padding: isSmall
          ? const EdgeInsets.symmetric(horizontal: 11.5, vertical: 6.25)
          : EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 6),
      decoration: ShapeDecoration(
        color: fill,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: border),
          borderRadius: BorderRadius.circular(16777200),
        ),
      ),
      child: Center(child: Text(text, style: style)),
    );
  }
}


