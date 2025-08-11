import 'package:flutter/material.dart';
import '../../design_system/components/primary_button.dart';
import '../../design_system/components/secondary_button.dart';
import '../../design_system/components/alternative_button.dart';
import '../../design_system/components/text_field.dart';

class ButtonsDemoScreen extends StatelessWidget {
  const ButtonsDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new), onPressed: () => Navigator.of(context).maybePop()),
        title: const Text('Buttons'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          const SizedBox(height: 8),
          const PrimaryButton(label: 'Login', onPressed: _noop),
          const SizedBox(height: 8),
          Text('Tokens usados: fillBrand, fillBrandPressed, typographyInvertedStrong, typography.buttonPrimary',
              style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 24),
          const SecondaryButton(label: 'Login', onPressed: _noop),
          const SizedBox(height: 8),
          Text('Tokens usados: strokeBrand, fillBrandWeak (pressed bg), typographyBrand, typography.buttonPrimary, radiusPill, spacingLg/spacingMd',
              style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 24),
          const AlternativeButton(label: 'Login', onPressed: _noop),
          const SizedBox(height: 8),
          Text('Tokens usados: fillPrimaryStrong, fillPrimaryPressed, typographyInvertedStrong, typography.buttonPrimary, radiusPill, spacingLg/spacingMd',
              style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 24),
          const BrandTextField(hintText: 'Nome Do Usuário'),
          const SizedBox(height: 8),
          Text('TextField tokens: fillBrandWeak (background), strokeBrand (border), typographyBrand (text), radiusPill, spacingLg/spacingMd',
              style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

void _noop() {}


