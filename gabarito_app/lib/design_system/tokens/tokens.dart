import 'dart:ui';

class PrimaryPalette {
  const PrimaryPalette(this.colors);
  final Map<String, Color> colors;
}

class SemanticPalette {
  const SemanticPalette(this.colors);
  final Map<String, Color> colors;
}

class TextStyleToken {
  const TextStyleToken({
    required this.fontSize,
    required this.fontWeight,
    required this.height,
    required this.letterSpacing,
  });

  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final double letterSpacing;

  static TextStyleToken fromMap(Map<String, dynamic> map) {
    double parseNum(dynamic v, double fallback) => v is num ? v.toDouble() : fallback;
    double fontSize = parseNum(map['fontSize'], 16);
    double height = parseNum(map['height'], 1.2);
    if (height > 3) height = height / 100.0; // allow 101 => 1.01
    double letterSpacing = parseNum(map['letterSpacing'], 0);
    int weightNum = (map['fontWeight'] is num) ? (map['fontWeight'] as num).round() : 400;
    weightNum = weightNum.clamp(100, 900);
    final FontWeight weight = FontWeight.values[((weightNum / 100).round() - 1).clamp(0, 8)];
    return TextStyleToken(
      fontSize: fontSize,
      fontWeight: weight,
      height: height,
      letterSpacing: letterSpacing,
    );
  }
}

class DesignTokens {
  DesignTokens({
    required this.brand,
    required this.brandPressed,
    required this.textPrimary,
    required this.textOnBrand,
    required this.textInvertedStrong,
    required this.bgCanvas,
    required this.bgSurface,
    required this.radiusMd,
    required this.radiusLg,
    required this.radiusPill,
    required this.spacingXs,
    required this.spacingSm,
    required this.spacingMd,
    required this.spacingLg,
    required this.primaries,
    required this.semantics,
    required this.typography,
    required this.fontFamily,
    required this.motionPressScale,
    required this.motionPressInMs,
    required this.motionPressOutMs,
    required this.buttonInnerShadow,
  });

  final Color brand;
  final Color brandPressed;
  final Color textPrimary;
  final Color textOnBrand;
  final Color textInvertedStrong;
  final Color bgCanvas;
  final Color bgSurface;
  final double radiusMd;
  final double radiusLg;
  final double radiusPill;
  final double spacingXs;
  final double spacingSm;
  final double spacingMd;
  final double spacingLg;
  final PrimaryPalette primaries;
  final SemanticPalette semantics;
  final Map<String, TextStyleToken> typography;
  final String fontFamily;
  // Motion tokens
  final double motionPressScale; // e.g., 0.96
  final int motionPressInMs; // e.g., 180
  final int motionPressOutMs; // e.g., 120
  // Effects
  final InnerShadowToken buttonInnerShadow;

  static DesignTokens fallback() {
    return DesignTokens(
      brand: const Color(0xFF4361EE),
      brandPressed: const Color(0xFF6388FF),
      textPrimary: const Color(0xFF1F2937),
      textOnBrand: const Color(0xFFFFFFFF),
      textInvertedStrong: const Color(0xFF1A1B1C),
      bgCanvas: const Color(0xFFFFFFFF),
      bgSurface: const Color(0xFFF8FAFC),
      radiusMd: 12,
      radiusLg: 16,
      radiusPill: 999,
      spacingXs: 8,
      spacingSm: 12,
      spacingMd: 16,
      spacingLg: 24,
      primaries: const PrimaryPalette(<String, Color>{}),
      semantics: const SemanticPalette(<String, Color>{}),
      typography: <String, TextStyleToken>{
        'body': const TextStyleToken(fontSize: 16, fontWeight: FontWeight.w400, height: 1.30, letterSpacing: 0),
        'bodyBold': const TextStyleToken(fontSize: 16, fontWeight: FontWeight.w700, height: 1.30, letterSpacing: 0),
        'bodySmall': const TextStyleToken(fontSize: 12, fontWeight: FontWeight.w400, height: 1.30, letterSpacing: 0),
        'h1': const TextStyleToken(fontSize: 32, fontWeight: FontWeight.w700, height: 1.01, letterSpacing: 0),
        'h2': const TextStyleToken(fontSize: 24, fontWeight: FontWeight.w700, height: 1.20, letterSpacing: 0),
        'h3': const TextStyleToken(fontSize: 20, fontWeight: FontWeight.w700, height: 1.30, letterSpacing: 0),
        'h4': const TextStyleToken(fontSize: 18, fontWeight: FontWeight.w700, height: 1.01, letterSpacing: -0.36),
        'h4Bold': const TextStyleToken(fontSize: 18, fontWeight: FontWeight.w800, height: 1.01, letterSpacing: -0.36),
        'buttonPrimary': const TextStyleToken(fontSize: 18, fontWeight: FontWeight.w800, height: 1.01, letterSpacing: -0.36),
      },
      fontFamily: 'Nunito',
      motionPressScale: 0.96,
      motionPressInMs: 180,
      motionPressOutMs: 120,
      buttonInnerShadow: InnerShadowToken(
        color: const Color(0x2B000000), // ~17% alpha black
        x: -6.72,
        y: -5.38,
        blur: 0,
        spread: 0,
      ),
    );
  }

  factory DesignTokens.fromJson(Map<String, dynamic> json) {
    // Support both Tokens Studio-like schema and the provided Figma export schema
    final Map<String, dynamic> global = json['global'] as Map<String, dynamic>? ?? <String, dynamic>{};
    final Map<String, dynamic> color = _map(global['color']);
    final Map<String, dynamic> font = _map(global['font']);
    final Map<String, dynamic> radius = _map(global['radius']);
    final Map<String, dynamic> spacing = _map(global['spacing']);

    final Map<String, dynamic> primaryColors = _map(_map(json['primaryColors'])['mode1']);
    final Map<String, dynamic> semanticColors = _map(_map(json['semanticColors'])['mode1']);
    final Map<String, dynamic> general = _map(_map(json['general'])['mode1']);
    final Map<String, dynamic> typographyRaw = _map(_map(json['typography'])['mode1']);

    Color parseColor(dynamic value, {Color? orElse}) {
      if (value is Map && value['value'] != null) {
        return _hexToColor(value['value'] as String);
      } else if (value is String) {
        return _hexToColor(value);
      }
      return orElse ?? const Color(0xFF000000);
    }

    double parseDouble(dynamic value, {double orElse = 0}) {
      if (value is Map && value['value'] != null) {
        return (value['value'] as num).toDouble();
      } else if (value is num) {
        return value.toDouble();
      }
      return orElse;
    }

    String parseString(dynamic value, {String orElse = ''}) {
      if (value is Map && value['value'] != null) {
        return value['value'].toString();
      } else if (value is String) {
        return value;
      }
      return orElse;
    }

    // Prefer provided Figma schema values when available, otherwise fall back to Tokens Studio-like keys
    final Color brand = parseColor(semanticColors['fillBrand'] ?? primaryColors['green100'] ?? color['brand'], orElse: const Color(0xFF4361EE));
    final Color brandPressed = parseColor(semanticColors['fillBrandPressed'] ?? primaryColors['green40'], orElse: brand);
    final Color textPrimary =
        parseColor(semanticColors['typographyPrimaryStrong'] ?? color['textPrimary'], orElse: const Color(0xFF1F2937));
    final Color textInvertedStrong = parseColor(semanticColors['typographyInvertedStrong'] ?? primaryColors['neutralDark100'], orElse: const Color(0xFF1A1B1C));
    final Color textOnBrand = parseColor(semanticColors['iconPrimary'] ?? color['textOnBrand'], orElse: const Color(0xFFFFFFFF));
    final Color bgCanvas =
        parseColor(semanticColors['backgroundPrimary'] ?? color['bgCanvas'], orElse: const Color(0xFFFFFFFF));
    final Color bgSurface =
        parseColor(semanticColors['backgroundElevated'] ?? color['bgSurface'], orElse: const Color(0xFFF8FAFC));
    final String fontFamily = parseString(font['family'], orElse: 'Nunito');

    final double radiusMd = parseDouble(radius['md'], orElse: 12);
    final double radiusLg = parseDouble(radius['lg'], orElse: 16);
    final double radiusPill = parseDouble(general['cornerRadiusPill'], orElse: 999);

    final double spacingXs = parseDouble(spacing['xs'] ?? general['spacing4'], orElse: 8);
    final double spacingSm = parseDouble(spacing['sm'] ?? general['spacing16'], orElse: 12);
    final double spacingMd = parseDouble(spacing['md'] ?? general['spacing24'], orElse: 16);
    final double spacingLg = parseDouble(spacing['lg'] ?? general['spacing32'], orElse: 24);

    // Build typography map
    final Map<String, TextStyleToken> typography = <String, TextStyleToken>{};
    typographyRaw.forEach((String k, dynamic v) {
      if (v is Map<String, dynamic>) {
        typography[k] = TextStyleToken.fromMap(v);
      }
    });
    // Motion
    final Map<String, dynamic> motionRaw = _map(_map(json['motion'])['mode1']);
    final double motionPressScale = (motionRaw['pressScale'] is num) ? (motionRaw['pressScale'] as num).toDouble() : 0.96;
    final int motionPressInMs = (motionRaw['pressInMs'] is num) ? (motionRaw['pressInMs'] as num).round() : 180;
    final int motionPressOutMs = (motionRaw['pressOutMs'] is num) ? (motionRaw['pressOutMs'] as num).round() : 120;

    // Effects
    final Map<String, dynamic> effectsRaw = _map(_map(json['effects'])['mode1']);
    InnerShadowToken innerShadow = DesignTokens.fallback().buttonInnerShadow;
    if (effectsRaw['buttonInnerShadow'] is Map<String, dynamic>) {
      final Map<String, dynamic> m = effectsRaw['buttonInnerShadow'] as Map<String, dynamic>;
      innerShadow = InnerShadowToken(
        color: _hexToColor((m['color'] as String?) ?? '#00000017'),
        x: (m['x'] as num?)?.toDouble() ?? innerShadow.x,
        y: (m['y'] as num?)?.toDouble() ?? innerShadow.y,
        blur: (m['blur'] as num?)?.toDouble() ?? innerShadow.blur,
        spread: (m['spread'] as num?)?.toDouble() ?? innerShadow.spread,
      );
    }

    return DesignTokens(
      brand: brand,
      brandPressed: brandPressed,
      textPrimary: textPrimary,
      textOnBrand: textOnBrand,
      textInvertedStrong: textInvertedStrong,
      bgCanvas: bgCanvas,
      bgSurface: bgSurface,
      radiusMd: radiusMd,
      radiusLg: radiusLg,
      radiusPill: radiusPill,
      spacingXs: spacingXs,
      spacingSm: spacingSm,
      spacingMd: spacingMd,
      spacingLg: spacingLg,
      primaries: PrimaryPalette(_parseColorMap(primaryColors)),
      semantics: SemanticPalette(_parseColorMap(semanticColors)),
      typography: typography.isNotEmpty ? typography : DesignTokens.fallback().typography,
      fontFamily: fontFamily,
      motionPressScale: motionPressScale,
      motionPressInMs: motionPressInMs,
      motionPressOutMs: motionPressOutMs,
      buttonInnerShadow: innerShadow,
    );
  }

  static Map<String, dynamic> _map(dynamic v) => (v as Map<String, dynamic>?) ?? <String, dynamic>{};

  static Map<String, Color> _parseColorMap(Map<String, dynamic> input) {
    final Map<String, Color> out = <String, Color>{};
    input.forEach((String k, dynamic v) {
      if (v is String) out[k] = _hexToColor(v);
    });
    return out;
  }

  static Color _hexToColor(String hex) {
    String cleaned = hex.replaceAll('#', '').toUpperCase();
    // Supports: RRGGBB, AARRGGBB, and RRGGBBAA (alpha suffix like 'B2')
    if (cleaned.length == 6) {
      cleaned = 'FF$cleaned';
    } else if (cleaned.length == 8) {
      final String last2 = cleaned.substring(6, 8);
      final Set<String> suffixAlpha = <String>{'00','0C','11','14','19','1F','26','33','4C','66','80','99','B2','CC','E5','FF'};
      if (suffixAlpha.contains(last2)) {
        // Convert RRGGBBAA -> AARRGGBB
        cleaned = '$last2${cleaned.substring(0, 6)}';
      }
    }
    final int val = int.parse(cleaned, radix: 16);
    return Color(val);
  }
}

class InnerShadowToken {
  const InnerShadowToken({required this.color, required this.x, required this.y, required this.blur, required this.spread});
  final Color color;
  final double x;
  final double y;
  final double blur;
  final double spread;
}


