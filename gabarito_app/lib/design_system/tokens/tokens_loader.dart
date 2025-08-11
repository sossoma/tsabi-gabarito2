import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'tokens.dart';

class TokensLoader {
  const TokensLoader._();

  static Future<DesignTokens> loadFromAsset(String path) async {
    try {
      final String raw = await rootBundle.loadString(path);
      final Map<String, dynamic> data = jsonDecode(raw) as Map<String, dynamic>;
      return DesignTokens.fromJson(data);
    } catch (_) {
      return DesignTokens.fallback();
    }
  }
}


