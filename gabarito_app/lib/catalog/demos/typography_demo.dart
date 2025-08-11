import 'package:flutter/material.dart';
import '../../design_system/theme/app_tokens_extension.dart';

class TypographyDemoScreen extends StatelessWidget {
  const TypographyDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new), onPressed: () => Navigator.of(context).maybePop()),
        title: const Text('Typography'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Text('From tokens.json (typography.mode1):', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...tokens.typography.entries.map((entry) {
            final s = entry.value;
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(entry.key),
              subtitle: Text('size ${s.fontSize}, weight ${_weightName(s.fontWeight)}, height ${s.height.toStringAsFixed(2)}, letter ${s.letterSpacing}'),
              trailing: Text(
                'Ag',
                style: TextStyle(
                  fontFamily: tokens.fontFamily,
                  fontSize: s.fontSize,
                  fontWeight: s.fontWeight,
                  height: s.height,
                  letterSpacing: s.letterSpacing,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

String _weightName(FontWeight w) {
  const map = <FontWeight, String>{
    FontWeight.w100: '100',
    FontWeight.w200: '200',
    FontWeight.w300: '300',
    FontWeight.w400: '400',
    FontWeight.w500: '500',
    FontWeight.w600: '600',
    FontWeight.w700: '700',
    FontWeight.w800: '800',
    FontWeight.w900: '900',
  };
  return map[w] ?? '—';
}


