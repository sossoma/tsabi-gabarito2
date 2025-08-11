import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../design_system/theme/app_tokens_extension.dart';
import '../../design_system/components/badge.dart';
import '../../design_system/components/black_button.dart';
import '../../design_system/components/icon_circle_button.dart';
import '../../design_system/components/expandable_panel.dart';
import '../../design_system/components/ranking_item.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final base = GoogleFonts.getFont(t.fontFamily);

    final TextStyle title24 = base.copyWith(fontSize: 24, fontWeight: FontWeight.w800, height: 1.20, letterSpacing: -0.48, color: t.brand);
    final TextStyle h4 = base.copyWith(fontSize: 18, fontWeight: FontWeight.w600, height: 1.01, letterSpacing: -0.36, color: Colors.white);
    final TextStyle smallMuted = base.copyWith(fontSize: 12, color: Colors.white.withValues(alpha: 0.5));

    return Scaffold(
      backgroundColor: t.bgCanvas,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Top bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => context.pop(),
                          child: Row(
                            children: <Widget>[
                              Image.asset('assets/images/icon-arrowleft.png', width: 17.5, height: 17.5, color: t.brand, errorBuilder: (_, __, ___) => const SizedBox()),
                              SizedBox(width: t.spacingXs / 2),
                              Text('Voltar', style: base.copyWith(color: t.brand, fontWeight: FontWeight.w700, fontSize: 14, height: 1.5)),
                            ],
                          ),
                        ),
                        Row(children: const <Widget>[
                          IconCircleButton(assetPath: 'assets/images/icon-ranking.png'),
                          SizedBox(width: 10.5),
                          IconCircleButton(assetPath: 'assets/images/icon-check-small.png'),
                        ]),
                      ],
                    ),
                    SizedBox(height: t.spacingLg),
                    Center(child: BrandBadge(text: 'GABARITO EXTRA OFICIAL REVISADO', variant: BrandBadgeVariant.brandWeak, size: BrandBadgeSize.small)),
                    SizedBox(height: t.spacingMd),
                    // Header card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.07),
                        border: Border.all(color: t.brand.withValues(alpha: 0.2)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Concurso Público 2024', style: title24),
                          SizedBox(height: 6),
                          Text('Conhecimentos Gerais', style: base.copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800, height: 1.3, letterSpacing: -0.32)),
                          SizedBox(height: 6),
                          Text('50 questões • Gerado em 09/08/2025', style: base.copyWith(color: Colors.white.withValues(alpha: 0.70), fontSize: 16, fontWeight: FontWeight.w600, height: 1.3, letterSpacing: -0.32)),
                        ],
                      ),
                    ),
                    SizedBox(height: t.spacingLg),
                    // Score card
                    Container(
                      padding: EdgeInsets.all(t.spacingLg),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.07),
                        border: Border.all(color: t.brand.withValues(alpha: 0.2)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text('41/50', textAlign: TextAlign.center, style: base.copyWith(color: t.brand, fontSize: 32, fontWeight: FontWeight.w800, height: 1.01, letterSpacing: -0.64)),
                          SizedBox(height: 7),
                          Text('82% de acerto', textAlign: TextAlign.center, style: base.copyWith(color: Colors.white.withValues(alpha: 0.70), fontSize: 16, fontWeight: FontWeight.w600, height: 1.3, letterSpacing: -0.32)),
                          SizedBox(height: t.spacingSm),
                          Text('Bom trabalho', textAlign: TextAlign.center, style: base.copyWith(color: t.primaries.colors['blue100'] ?? Colors.lightBlueAccent, fontSize: 20, fontWeight: FontWeight.w700, height: 1.5)),
                          SizedBox(height: t.spacingMd),
                          Divider(color: t.brand.withValues(alpha: 0.2)),
                          SizedBox(height: t.spacingSm),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('assets/images/icon-ranking.png', width: 17.5, height: 17.5, color: t.brand, errorBuilder: (_, __, ___) => const SizedBox()),
                              SizedBox(width: t.spacingXs / 2),
                              Text('Ranking', style: base.copyWith(color: t.brand, fontSize: 16, fontWeight: FontWeight.w800, height: 1.3, letterSpacing: -0.32)),
                            ],
                          ),
                          SizedBox(height: t.spacingSm),
                          Text('85º lugar', textAlign: TextAlign.center, style: base.copyWith(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800, height: 1.20, letterSpacing: -0.48)),
                          Text('de 219 alunos', textAlign: TextAlign.center, style: base.copyWith(color: Colors.white.withValues(alpha: 0.70), fontSize: 16, fontWeight: FontWeight.w600, height: 1.3, letterSpacing: -0.32)),
                          SizedBox(height: t.spacingSm),
                          // Ranking cards
                          const SizedBox(height: 16),
                          RankingItem(rank: 83, name: 'Estudante E', scoreText: '44/50'),
                          const SizedBox(height: 12),
                          RankingItem(rank: 84, name: 'Estudante F', scoreText: '45/50'),
                          const SizedBox(height: 12),
                          RankingItem(rank: 85, name: 'Você', scoreText: '41/50', isYou: true),
                          const SizedBox(height: 12),
                          RankingItem(rank: 86, name: 'Estudante H', scoreText: '29/50'),
                          const SizedBox(height: 12),
                          RankingItem(rank: 87, name: 'Estudante I', scoreText: '31/50'),
                          const SizedBox(height: 12),
                          Text('219 alunos participaram', textAlign: TextAlign.center, style: smallMuted),
                        ],
                      ),
                    ),
                    SizedBox(height: t.spacingLg),
                    // Gabarito rápido
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.07),
                        border: Border.all(color: t.brand.withValues(alpha: 0.2)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Gabarito Rápido', style: base.copyWith(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700, height: 1.5)),
                          SizedBox(height: t.spacingSm),
                          Wrap(
                            spacing: 10,
                            runSpacing: 13,
                            children: List<Widget>.generate(12, (int i) {
                              final bool wrong = i == 7;
                              final Color bg = wrong ? const Color(0x0CFF6467) : const Color(0x4C0D532B);
                              final Color border = wrong ? const Color(0x4CFF6467) : const Color(0x7F00C850);
                              final Color ans = wrong ? const Color(0xFFFF6366) : const Color(0xFF05DF72);
                              return Container(
                                width: 70.4,
                                padding: const EdgeInsets.all(11.5),
                                decoration: ShapeDecoration(
                                  color: bg,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 1, color: border),
                                    borderRadius: BorderRadius.circular(8.75),
                                  ),
                                ),
                                child: Column(children: <Widget>[
                                  Text('${i + 1}', textAlign: TextAlign.center, style: smallMuted.copyWith(color: const Color(0xB2FFFEFE))),
                                  const SizedBox(height: 3.5),
                                  Text(i == 6 ? 'V' : ['A','B','C','D','E'][i % 5], textAlign: TextAlign.center, style: base.copyWith(color: ans, fontSize: 16, fontWeight: FontWeight.w800, height: 1.3, letterSpacing: -0.32)),
                                  const SizedBox(height: 6),
                                  Image.asset(
                                    wrong ? 'assets/images/icon-x-small.png' : 'assets/images/icon-check-small.png',
                                    width: 10.5,
                                    height: 10.5,
                                    color: wrong ? const Color(0xFFFF6366) : const Color(0xFF05DF72),
                                    errorBuilder: (_, __, ___) => const SizedBox(height: 10.5),
                                  ),
                                ]),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: t.spacingLg),
                    // Questões comentadas (one sample as expandable)
                    Text('Questões Comentadas', style: base.copyWith(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700, height: 1.5)),
                    SizedBox(height: t.spacingSm),
                    ExpandablePanel(
                      header: Row(
                        children: <Widget>[
                          CircleAvatar(backgroundColor: t.brand, radius: 14, child: Text('1', style: base.copyWith(color: t.textInvertedStrong, fontWeight: FontWeight.w700))),
                          SizedBox(width: t.spacingSm),
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                            Text('Resposta: C', style: h4.copyWith(fontWeight: FontWeight.w800)),
                            Text('Estatística', style: base.copyWith(color: t.brand, fontSize: 16, fontWeight: FontWeight.w600, height: 1.3, letterSpacing: -0.32)),
                          ]),
                        ],
                      ),
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(style: base.copyWith(fontSize: 16, height: 1.3), children: <TextSpan>[
                              TextSpan(text: 'Sua resposta: ', style: base.copyWith(color: Colors.white.withValues(alpha: 0.70), fontWeight: FontWeight.w600, letterSpacing: -0.32)),
                              TextSpan(text: 'B', style: base.copyWith(color: const Color(0xFFFF6366), fontWeight: FontWeight.w800, letterSpacing: -0.32)),
                              TextSpan(text: '  Correta: ', style: base.copyWith(color: Colors.white.withValues(alpha: 0.70), fontWeight: FontWeight.w600, letterSpacing: -0.32)),
                              TextSpan(text: 'A', style: base.copyWith(color: t.brand, fontWeight: FontWeight.w800, letterSpacing: -0.32)),
                            ]),
                          ),
                          const SizedBox(height: 12),
                          Text('Explicação:', style: base.copyWith(color: Colors.white, fontWeight: FontWeight.w800, height: 1.3, letterSpacing: -0.32)),
                          const SizedBox(height: 6),
                          Text('A resposta A é correta considerando as propriedades matemáticas do conjunto numérico.', style: base.copyWith(color: Colors.white.withValues(alpha: 0.70), fontWeight: FontWeight.w600, height: 1.3, letterSpacing: -0.32)),
                        ],
                      ),
                    ),
                    SizedBox(height: t.spacingLg),
                    // CTA box (tokenized spacing and typography)
                    Builder(builder: (BuildContext context) {
                      final h2 = t.typography['h2'];
                      final body = t.typography['body'];
                      final TextStyle titleStyle = base.copyWith(
                        color: t.textInvertedStrong,
                        fontSize: h2?.fontSize ?? 24,
                        fontWeight: h2?.fontWeight ?? FontWeight.w800,
                        height: h2?.height ?? 1.20,
                        letterSpacing: h2?.letterSpacing ?? -0.48,
                      );
                      final TextStyle descStyle = base.copyWith(
                        color: t.textInvertedStrong,
                        fontSize: body?.fontSize ?? 16,
                        fontWeight: FontWeight.w600,
                        height: body?.height ?? 1.30,
                        letterSpacing: body?.letterSpacing ?? -0.32,
                      );
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: t.spacingLg, vertical: t.spacingLg),
                        decoration: BoxDecoration(color: t.brand, borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 390),
                              child: Text('Gostaria de entrar com recurso?', textAlign: TextAlign.center, style: titleStyle),
                            ),
                            SizedBox(height: t.spacingSm),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 390),
                              child: Text('Se você achar que a sua prova foi corrigida indevidamente,gere o recurso de forma rápida e certeira.', textAlign: TextAlign.center, style: descStyle),
                            ),
                            SizedBox(height: t.spacingSm),
                            BlackButton(label: 'Gerar recurso', onPressed: () {}),
                          ],
                        ),
                      );
                    }),
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


