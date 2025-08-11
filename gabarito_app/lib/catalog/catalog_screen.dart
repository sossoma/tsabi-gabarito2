import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catalog')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: const <Widget>[
          _SectionHeader('Design Tokens'),
          _NavTile(title: 'Tokens', subtitle: 'Colors, spacing, radius, typography', routeName: 'demo_tokens'),
          SizedBox(height: 24),
          _SectionHeader('Components'),
          _NavTile(title: 'Buttons', subtitle: 'Primary, states & interactions', routeName: 'demo_buttons'),
          _NavTile(title: 'Typography', subtitle: 'Text styles & scale', routeName: 'demo_typography'),
          _NavTile(title: 'Spacing', subtitle: 'Space scale preview', routeName: 'demo_spacing'),
          SizedBox(height: 24),
          _SectionHeader('Pages'),
          _NavTile(title: 'Splash', subtitle: 'Intro screen', routeName: 'page_splash'),
          _NavTile(title: 'Getting Started', subtitle: 'Camera instructions', routeName: 'page_getting_started'),
          _NavTile(title: 'Take Photos', subtitle: 'Camera preview + actions', routeName: 'page_take_photos'),
          _NavTile(title: 'Results', subtitle: 'Score + commented answers', routeName: 'page_results'),
          _NavTile(title: 'Login', subtitle: 'Auth entry screen (stub)', routeName: 'page_login'),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({required this.title, this.subtitle, required this.routeName});
  final String title;
  final String? subtitle;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.pushNamed(routeName),
    );
  }
}


