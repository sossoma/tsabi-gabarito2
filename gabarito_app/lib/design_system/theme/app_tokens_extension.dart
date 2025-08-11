import 'package:flutter/material.dart';
import '../tokens/tokens.dart';

class TokensExtension extends ThemeExtension<TokensExtension> {
  const TokensExtension({required this.tokens});

  final DesignTokens tokens;

  @override
  ThemeExtension<TokensExtension> copyWith({DesignTokens? tokens}) => TokensExtension(tokens: tokens ?? this.tokens);

  @override
  ThemeExtension<TokensExtension> lerp(ThemeExtension<TokensExtension>? other, double t) => this;
}

extension TokensX on BuildContext {
  DesignTokens get tokens => Theme.of(this).extension<TokensExtension>()!.tokens;
}


