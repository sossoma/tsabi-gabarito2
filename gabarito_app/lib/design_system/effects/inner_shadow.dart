import 'package:flutter/material.dart';

class InnerShadow extends StatelessWidget {
  const InnerShadow({
    super.key,
    required this.color,
    required this.blur,
    required this.offset,
    required this.radius,
    this.spread = 0,
  });

  final Color color;
  final double blur;
  final Offset offset;
  final double radius;
  final double spread;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CustomPaint(
        painter: _InnerShadowPainter(
          color: color,
          blur: blur,
          offset: offset,
          spread: spread,
          radius: radius,
        ),
      ),
    );
  }
}

class _InnerShadowPainter extends CustomPainter {
  _InnerShadowPainter({
    required this.color,
    required this.blur,
    required this.offset,
    required this.spread,
    required this.radius,
  });

  final Color color;
  final double blur;
  final Offset offset;
  final double spread;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    // Outer rect bigger to host the blurred shadow
    final double inflate = blur + 20;
    final Rect outerRect = rect.inflate(inflate);
    final RRect outerRRect = RRect.fromRectAndRadius(outerRect, Radius.circular(radius + inflate));

    final Path outerPath = Path()..addRRect(outerRRect);
    final Path innerPath = Path()..addRRect(rrect.deflate(spread));
    final Path shadowPath = Path.combine(PathOperation.difference, outerPath, innerPath);

    canvas.save();
    canvas.clipRRect(rrect);
    canvas.translate(-offset.dx, -offset.dy);
    final Paint paint = Paint()
      ..color = color
      ..maskFilter = blur > 0 ? MaskFilter.blur(BlurStyle.normal, blur) : null;
    canvas.drawPath(shadowPath, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _InnerShadowPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.blur != blur ||
        oldDelegate.offset != offset ||
        oldDelegate.spread != spread ||
        oldDelegate.radius != radius;
  }
}


