import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../design_system/theme/app_tokens_extension.dart';

class ProcessingStatusPage extends StatelessWidget {
  const ProcessingStatusPage({super.key, this.totalPhotos = 0, this.progress = 0.3});

  final int totalPhotos;
  final double progress; // 0..1 overall progress

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final base = GoogleFonts.getFont(t.fontFamily);

    final TextStyle titleStyle = base.copyWith(
      color: t.textInvertedStrong,
      fontSize: (t.typography['h1']?.fontSize) ?? 32,
      fontWeight: FontWeight.w800,
      height: 1.01,
      letterSpacing: -0.64,
    );

    final TextStyle stepActive = base.copyWith(
      color: t.textInvertedStrong,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.12,
      letterSpacing: -0.36,
    );
    final TextStyle stepMuted = stepActive.copyWith(color: t.textInvertedStrong.withValues(alpha: 0.40));

    final double trackWidth = 338;
    final double trackHeight = 7.35;
    final double fillWidth = (trackWidth * progress).clamp(0, trackWidth);

    return Scaffold(
      backgroundColor: t.brand, // Background-Brand
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(t.spacingLg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 338,
                child: Text('Processando\nGabarito', textAlign: TextAlign.center, style: titleStyle),
              ),
              SizedBox(height: t.spacingLg + t.spacingSm),
              // Progress bar track and fill
              SizedBox(
                width: trackWidth,
                height: trackHeight,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: t.textInvertedStrong,
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: fillWidth,
                        decoration: BoxDecoration(
                          color: (t.primaries.colors['green100']) ?? t.brandPressed,
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: t.spacingLg),
              SizedBox(
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Step 1
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _CheckIcon(active: true, color: t.textInvertedStrong),
                        SizedBox(width: t.spacingSm),
                        Flexible(
                          child: Text('Analisando ${totalPhotos} fotos', textAlign: TextAlign.center, style: stepActive),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text('Reconhecendo Texto', textAlign: TextAlign.center, style: stepMuted),
                    SizedBox(height: 15),
                    Text('Processando com IA...', textAlign: TextAlign.center, style: stepMuted),
                    SizedBox(height: 15),
                    Text('Gerando gabarito comentado', textAlign: TextAlign.center, style: stepMuted),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckIcon extends StatelessWidget {
  const _CheckIcon({required this.active, required this.color});
  final bool active;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: active ? 1 : 0.5), width: 1.5),
      ),
      child: Center(
        child: Icon(Icons.check, size: 12, color: color.withValues(alpha: active ? 1 : 0.5)),
      ),
    );
  }
}


