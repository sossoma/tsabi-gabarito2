import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_tokens_extension.dart';

class RankingItem extends StatelessWidget {
  const RankingItem({
    super.key,
    required this.rank,
    required this.name,
    required this.scoreText,
    this.isYou = false,
  });

  final int rank;
  final String name;
  final String scoreText;
  final bool isYou;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final TextStyle base = GoogleFonts.getFont(t.fontFamily);

    final Color bg = isYou ? const Color(0x0C96FF7F) : const Color(0x7F1A1B1C);
    final BoxBorder? border = isYou
        ? Border.all(width: 1, color: const Color(0x4C96FF7F))
        : null;
    final Color chipBg = isYou ? t.brand : Colors.white.withValues(alpha: 0.20);
    final Color chipText = isYou ? t.textInvertedStrong : Colors.white;
    final TextStyle nameStyle = base.copyWith(
      color: isYou ? t.brand : Colors.white.withValues(alpha: 0.70),
      fontSize: 16,
      fontWeight: isYou ? FontWeight.w800 : FontWeight.w600,
      height: 1.30,
      letterSpacing: -0.32,
    );
    final TextStyle scoreStyle = base.copyWith(
      color: isYou ? t.brand : Colors.white.withValues(alpha: 0.70),
      fontSize: 16,
      fontWeight: isYou ? FontWeight.w800 : FontWeight.w600,
      height: 1.30,
      letterSpacing: -0.32,
    );

    return Container(
      decoration: ShapeDecoration(
        color: bg,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8.75),
        ),
      ),
      foregroundDecoration: border == null
          ? null
          : ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.75),
                side: BorderSide(color: (border as Border).top.color, width: (border as Border).top.width),
              ),
            ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(color: chipBg, borderRadius: BorderRadius.circular(9999)),
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 10.5),
            child: Text('$rank', style: base.copyWith(color: chipText, fontSize: 11, fontWeight: FontWeight.w700, height: 1.5)),
          ),
          Expanded(child: Text(name, style: nameStyle)),
          Text(scoreText, style: scoreStyle),
        ],
      ),
    );
  }
}


