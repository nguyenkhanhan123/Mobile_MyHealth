import 'dart:math' as math;
import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final double sweepAngleDeg;
  final Color color;
  final Color backgroundColor;

  const Circle({
    super.key,
    required this.size,
    required this.strokeWidth,
    required this.sweepAngleDeg,
    required this.color,
    required this.backgroundColor
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _CirclePainter(
          strokeWidth: strokeWidth,
          sweepAngleRad: -sweepAngleDeg * math.pi / 180,
          color: color,
          backgroundColor: backgroundColor
        ),
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  final double strokeWidth;
  final double sweepAngleRad;
  final Color color;
  final Color backgroundColor;

  _CirclePainter({
    required this.strokeWidth,
    required this.sweepAngleRad,
    required this.backgroundColor,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final arcRadius = size.width / 2 - 2*strokeWidth;
    final arcRect = Rect.fromCircle(center: center, radius: arcRadius);

    final bgRadius = arcRadius + strokeWidth;
    final bgRect = Rect.fromCircle(center: center, radius: bgRadius);

    final bgPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = backgroundColor
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(bgRect, 0, 2 * math.pi, false, bgPaint);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..color = color;
    canvas.drawArc(arcRect, (-90 * math.pi / 180), sweepAngleRad, false, paint);
  }


  @override
  bool shouldRepaint(covariant _CirclePainter old) {
    return strokeWidth != old.strokeWidth ||
        sweepAngleRad != old.sweepAngleRad ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
