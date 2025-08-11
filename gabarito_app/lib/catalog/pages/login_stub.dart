import 'package:flutter/material.dart';
import '../../design_system/components/primary_button.dart';
import '../../design_system/components/secondary_button.dart';
import '../../design_system/components/text_field.dart';
import '../../design_system/theme/app_tokens_extension.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../design_system/components/link.dart';
import 'package:go_router/go_router.dart';

class LoginStubPage extends StatelessWidget {
  const LoginStubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final base = GoogleFonts.getFont(t.fontFamily);
    final h1 = t.typography['h1'];
    final TextStyle h1Style = base.copyWith(
      fontSize: h1?.fontSize ?? 32,
      fontWeight: h1?.fontWeight ?? FontWeight.w700,
      height: h1?.height ?? 1.01,
      letterSpacing: h1?.letterSpacing ?? 0,
    );
    return Scaffold(
      backgroundColor: t.bgCanvas,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: t.spacingLg, vertical: t.spacingSm),
              sliver: SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  // Header brand (logo + wordmark)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('tsabi', style: h1Style.copyWith(color: t.textPrimary)),
                      SizedBox(width: t.spacingXs / 2),
                      Text('gabarito', style: h1Style.copyWith(color: t.brand)),
                    ],
                  ),
                  SizedBox(height: t.spacingSm),
                  // Illustration between logo and fields
                  Image.asset(
                    'assets/images/login-illustration.png',
                    height: 180,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                  ),
                  SizedBox(height: t.spacingSm),
                  // Middle group: fields and link (16px gaps)
                  BrandTextField(hintText: 'Nome Do Usuário'),
                  SizedBox(height: t.spacingMd),
                  const BrandTextField(hintText: 'Password', obscureText: true),
                  SizedBox(height: t.spacingMd),
                  const LinkText(text: 'Esqueceu sua senha?', onTap: _noop, textAlign: TextAlign.center),
                ]),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(t.spacingLg, t.spacingSm, t.spacingLg, t.spacingLg),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
            PrimaryButton(label: 'Login', onPressed: () => context.goNamed('page_getting_started')),
                    SizedBox(height: t.spacingMd),
                    const SecondaryButton(label: 'Criar Conta', onPressed: _noop),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _noop() {}


