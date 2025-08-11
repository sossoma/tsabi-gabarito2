import 'package:flutter/material.dart';
import 'design_system/theme/app_theme.dart';
import 'design_system/tokens/tokens.dart';
import 'design_system/tokens/tokens_loader.dart';
import 'package:go_router/go_router.dart';
import 'design_system/navigation/ios_transitions.dart';
import 'design_system/components/primary_button.dart';
import 'catalog/catalog_screen.dart';
import 'catalog/demos/buttons_demo.dart';
import 'catalog/demos/typography_demo.dart';
import 'catalog/demos/spacing_demo.dart';
import 'catalog/pages/login_stub.dart';
import 'catalog/demos/tokens_demo.dart';
import 'catalog/pages/splash_page.dart';
import 'catalog/pages/getting_started_page.dart';
import 'catalog/pages/take_photos_page.dart';
import 'catalog/pages/processing_status_page.dart';
import 'catalog/pages/results_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final DesignTokens tokens = await TokensLoader.loadFromAsset('assets/design_tokens/tokens.json');
  runApp(AppRoot(tokens: tokens));
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key, required this.tokens});

  final DesignTokens tokens;

  static final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const CatalogScreen(),
          transitionsBuilder: (context, animation, secondary, child) => iosTransition(context, animation, secondary, child),
        ),
      ),
      GoRoute(
        path: '/demo/tokens',
        name: 'demo_tokens',
        pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const TokensDemoScreen(),
          transitionsBuilder: (context, animation, secondary, child) => iosTransition(context, animation, secondary, child),
        ),
      ),
      GoRoute(
        path: '/demo/buttons',
        name: 'demo_buttons',
        pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const ButtonsDemoScreen(),
          transitionsBuilder: (context, animation, secondary, child) => iosTransition(context, animation, secondary, child),
        ),
      ),
      GoRoute(
        path: '/demo/typography',
        name: 'demo_typography',
        pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const TypographyDemoScreen(),
          transitionsBuilder: (context, animation, secondary, child) => iosTransition(context, animation, secondary, child),
        ),
      ),
      GoRoute(
        path: '/demo/spacing',
        name: 'demo_spacing',
        pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const SpacingDemoScreen(),
          transitionsBuilder: (context, animation, secondary, child) => iosTransition(context, animation, secondary, child),
        ),
      ),
      GoRoute(
        path: '/page/splash',
        name: 'page_splash',
        pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const SplashPage(),
          transitionsBuilder: (context, animation, secondary, child) => iosTransition(context, animation, secondary, child),
        ),
      ),
      GoRoute(
        path: '/page/getting-started',
        name: 'page_getting_started',
        pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const GettingStartedPage(),
          transitionsBuilder: (context, animation, secondary, child) => iosTransition(context, animation, secondary, child),
        ),
      ),
      GoRoute(
        path: '/page/take-photos',
        name: 'page_take_photos',
        pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const TakePhotosPage(),
          transitionsBuilder: (context, animation, secondary, child) => iosTransition(context, animation, secondary, child),
        ),
      ),
      GoRoute(
        path: '/page/processing-status',
        name: 'page_processing_status',
        pageBuilder: (BuildContext context, GoRouterState state) {
          final int total = (state.extra is Map && (state.extra as Map)['totalPhotos'] is int)
              ? (state.extra as Map)['totalPhotos'] as int
              : 0;
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: ProcessingStatusPage(totalPhotos: total),
            transitionsBuilder: (context, animation, secondary, child) =>
                iosTransition(context, animation, secondary, child),
          );
        },
      ),
      GoRoute(
        path: '/page/login',
        name: 'page_login',
        pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const LoginStubPage(),
          transitionsBuilder: (context, animation, secondary, child) => iosTransition(context, animation, secondary, child),
        ),
      ),
      GoRoute(
        path: '/page/results',
        name: 'page_results',
        pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const ResultsPage(),
          transitionsBuilder: (context, animation, secondary, child) => iosTransition(context, animation, secondary, child),
        ),
      ),
    ],
  );

  ThemeData _buildTheme(Brightness brightness) => AppTheme.materialTheme(brightness, tokens: tokens);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Gabarito',
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Gabarito')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Design System Base',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text('Flutter + iOS pronto. Abra a tela de componentes.'),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => context.goNamed('components'),
              child: const Text('Ver Componentes'),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: scheme.outlineVariant),
              ),
              child: Text(
                'Este app usa Material 3, go_router e Google Fonts.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ComponentsScreen extends StatelessWidget {
  const ComponentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Componentes')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SpacingDemo(),
            SizedBox(height: 12),
            ButtonsDemo(),
            SizedBox(height: 12),
            TypographyDemo(),
          ],
        ),
      ),
    );
  }
}

class SpacingDemo extends StatelessWidget {
  const SpacingDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List<Widget>.generate(
        6,
        (int i) => Container(
          width: 40 + i * 8,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

class ButtonsDemo extends StatelessWidget {
  const ButtonsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const PrimaryButton(label: 'Login', onPressed: _noop),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            OutlinedButton(onPressed: () {}, child: const Text('Outline')),
            const SizedBox(width: 8),
            TextButton(onPressed: () {}, child: const Text('Text')),
          ],
        ),
      ],
    );
  }
}

void _noop() {}

class TypographyDemo extends StatelessWidget {
  const TypographyDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme t = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Display Large', style: t.displayLarge),
        Text('Headline Medium', style: t.headlineMedium),
        Text('Title Large', style: t.titleLarge),
        Text('Body Medium', style: t.bodyMedium),
        Text('Label Small', style: t.labelSmall),
      ],
    );
  }
}
