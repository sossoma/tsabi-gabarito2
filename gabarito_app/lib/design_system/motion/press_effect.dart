import 'package:flutter/material.dart';
import '../theme/app_tokens_extension.dart';

class PressEffect extends StatefulWidget {
  const PressEffect({super.key, required this.child});

  final Widget child;

  @override
  State<PressEffect> createState() => _PressEffectState();
}

class _PressEffectState extends State<PressEffect> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
      reverseDuration: const Duration(milliseconds: 120),
    );
    _scale = Tween<double>(begin: 1, end: 0.96)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubicEmphasized, reverseCurve: Curves.easeInOutCubic));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // If tokens change at runtime, rebuild controller durations
    final tokens = context.tokens;
    _controller.duration = Duration(milliseconds: tokens.motionPressInMs);
    _controller.reverseDuration = Duration(milliseconds: tokens.motionPressOutMs);
    _scale = Tween<double>(begin: 1, end: tokens.motionPressScale)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubicEmphasized, reverseCurve: Curves.easeInOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _down(PointerDownEvent _) => _controller.forward();
  void _up(PointerUpEvent _) => _controller.reverse();
  void _cancel(PointerCancelEvent _) => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: _down,
      onPointerUp: _up,
      onPointerCancel: _cancel,
      child: AnimatedBuilder(
        animation: _scale,
        builder: (_, Widget? child) => Transform.scale(scale: _scale.value, child: child),
        child: widget.child,
      ),
    );
  }
}


