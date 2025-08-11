import 'package:flutter/material.dart';
import '../../design_system/theme/app_tokens_extension.dart';

class TokensDemoScreen extends StatelessWidget {
  const TokensDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new), onPressed: () => Navigator.of(context).maybePop()),
        title: const Text('Tokens'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          _Section('Primary Colors (from JSON)', children: <Widget>[
            ...t.primaries.colors.entries
                .map((e) => _ColorRow(label: e.key, color: e.value))
                .toList(),
          ]),
          const SizedBox(height: 16),
          _Section('Semantic Colors (from JSON)', children: <Widget>[
            ...t.semantics.colors.entries
                .map((e) => _ColorRow(label: e.key, color: e.value))
                .toList(),
          ]),
          const SizedBox(height: 16),
          _Section('Typography (from JSON)', children: <Widget>[
            ...t.typography.entries.map((e) {
              final s = e.value;
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(e.key),
                subtitle: Text('size ${s.fontSize}, weight ${_weightName(s.fontWeight)}, height ${s.height.toStringAsFixed(2)}, letter ${s.letterSpacing}'),
                trailing: Text('Ag',
                    style: TextStyle(
                      fontFamily: context.tokens.fontFamily,
                      fontSize: s.fontSize,
                      fontWeight: s.fontWeight,
                      height: s.height,
                      letterSpacing: s.letterSpacing,
                    )),
              );
            }).toList(),
          ]),
          const SizedBox(height: 16),
          _Section('Radius', children: <Widget>[
            _KV('radiusMd', t.radiusMd.toStringAsFixed(2)),
            _KV('radiusLg', t.radiusLg.toStringAsFixed(2)),
            _KV('radiusPill', t.radiusPill.toStringAsFixed(2)),
          ]),
          const SizedBox(height: 16),
          _Section('Spacing', children: <Widget>[
            _KV('xs', t.spacingXs.toStringAsFixed(0)),
            _KV('sm', t.spacingSm.toStringAsFixed(0)),
            _KV('md', t.spacingMd.toStringAsFixed(0)),
            _KV('lg', t.spacingLg.toStringAsFixed(0)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _SpacingBox('xs', t.spacingXs),
                _SpacingBox('sm', t.spacingSm),
                _SpacingBox('md', t.spacingMd),
                _SpacingBox('lg', t.spacingLg),
              ],
            )
          ]),
          const SizedBox(height: 16),
          _Section('Typography', children: <Widget>[
            _KV('fontFamily', t.fontFamily),
          ]),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section(this.title, {required this.children});
  final String title;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        ...children,
      ],
    );
  }
}

class _ColorRow extends StatelessWidget {
  const _ColorRow({required this.label, required this.color});
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(width: 28, height: 28, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.black12))),
      title: Text(label),
      subtitle: Text(_toHex(color)),
    );
  }
}

class _KV extends StatelessWidget {
  const _KV(this.k, this.v);
  final String k;
  final String v;
  @override
  Widget build(BuildContext context) {
    return ListTile(contentPadding: EdgeInsets.zero, title: Text(k), trailing: Text(v));
  }
}

class _SpacingBox extends StatelessWidget {
  const _SpacingBox(this.label, this.value);
  final String label;
  final double value;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(width: value, height: 12, color: Theme.of(context).colorScheme.primaryContainer),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}

String _toHex(Color c) {
  final int a = (c.a * 255).round();
  final int r = (c.r * 255).round();
  final int g = (c.g * 255).round();
  final int b = (c.b * 255).round();
  return '#${a.toRadixString(16).padLeft(2, '0')}${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}'.toUpperCase();
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


