import 'package:flutter/material.dart';
import '../theme/app_tokens_extension.dart';

class ExpandablePanel extends StatefulWidget {
  const ExpandablePanel({super.key, required this.header, required this.body, this.borderColor});

  final Widget header;
  final Widget body;
  final Color? borderColor;

  @override
  State<ExpandablePanel> createState() => _ExpandablePanelState();
}

class _ExpandablePanelState extends State<ExpandablePanel> with SingleTickerProviderStateMixin {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final Color border = widget.borderColor ?? t.semantics.colors['strokeBrandWeak'] ?? t.brand.withValues(alpha: 0.30);
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: t.bgSurface,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: border.withValues(alpha: 0.2)),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Column(
        children: <Widget>[
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => setState(() => _open = !_open),
            child: Padding(
              padding: EdgeInsets.all(t.spacingMd),
              child: Row(
                children: <Widget>[
                  Expanded(child: widget.header),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: _open ? 0.5 : 0,
                    child: const Icon(Icons.expand_more, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: EdgeInsets.fromLTRB(t.spacingMd, 0, t.spacingMd, t.spacingMd),
              child: widget.body,
            ),
            duration: const Duration(milliseconds: 200),
            crossFadeState: _open ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          ),
        ],
      ),
    );
  }
}


