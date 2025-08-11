import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_tokens_extension.dart';

class BrandTextField extends StatefulWidget {
  const BrandTextField({
    super.key,
    this.hintText = 'Nome Do Usuário',
    this.controller,
    this.width,
    this.obscureText = false,
    this.height = 60,
  });

  final String hintText;
  final TextEditingController? controller;
  final double? width;
  final bool obscureText;
  final double height;

  @override
  State<BrandTextField> createState() => _BrandTextFieldState();
}

class _BrandTextFieldState extends State<BrandTextField> {
  late final TextEditingController _controller = widget.controller ?? TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;

    final Color borderColor = t.semantics.colors['strokeBrand'] ?? t.brand;
    final Color fillWeak = t.semantics.colors['fillBrandWeak'] ?? t.brand.withValues(alpha: 0.05);
    final Color textColor = t.semantics.colors['typographyBrand'] ?? t.brand;
    final Color hintWeak = t.semantics.colors['typographyBrandWeak'] ?? textColor.withValues(alpha: 0.30);

    final TextStyle base = GoogleFonts.getFont(t.fontFamily);
    final TextStyle textStyle = base.copyWith(
      color: textColor,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.30,
      letterSpacing: -0.32,
    );

    final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(t.radiusPill),
      borderSide: BorderSide(color: borderColor, width: 1),
    );

    final InputDecoration decoration = InputDecoration(
      isDense: true,
      isCollapsed: true,
      hintText: widget.hintText,
      hintStyle: textStyle.copyWith(color: hintWeak),
      border: border,
      enabledBorder: border,
      focusedBorder: border,
      contentPadding: EdgeInsets.symmetric(
        horizontal: t.spacingLg,
        vertical: 16, // alinhar altura 60 como os botões
      ),
    );

    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height,
      decoration: BoxDecoration(color: fillWeak, borderRadius: BorderRadius.circular(t.radiusPill)),
      alignment: Alignment.center,
      child: SizedBox(
        height: widget.height,
        child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        style: textStyle,
        cursorColor: textColor,
        obscureText: widget.obscureText,
        textAlignVertical: TextAlignVertical.center,
        decoration: decoration,
      ),
      ),
    );
  }
}


