

import 'dart:math';
import 'package:flutter/material.dart';


class ProgressCirclePainter extends CustomPainter {
  final double circleRadius;
  final int topSpacing;
  final double progressWidth;
  final Color backgroundColor;
  final Color progressColor;
  final Color progressBackgroundColor;
  final double progress;
  final bool isAntiClockWiseProgress;
  final double strokeWidth = 8;
  final backgroundPaint = Paint();

  final progressPaint = Paint()..style = PaintingStyle.stroke;

  final progressBackgroundPaint = Paint()..style = PaintingStyle.stroke;

  ProgressCirclePainter({
    required this.circleRadius,
    this.topSpacing = 0,
    this.progressWidth = 8,
    this.backgroundColor = Colors.transparent,
    this.progressColor = Colors.pinkAccent,
    this.progressBackgroundColor = Colors.grey,
    this.progress = 0,
    this.isAntiClockWiseProgress = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = circleRadius + topSpacing;
    final center = Offset(centerX, centerY);

    const startAngle = (270 * pi) / 180;
    const totalAngle = (360 * pi) / 180;
    double progressAngel = (totalAngle * progress) / 100;
    if (isAntiClockWiseProgress) {
      progressAngel = -progressAngel;
    }

    backgroundPaint.color = backgroundColor;
    backgroundPaint.style = PaintingStyle.fill;
    progressBackgroundPaint
      ..strokeWidth = strokeWidth
      ..color = progressBackgroundColor;
    progressPaint
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = progressColor;

    final outer = RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height,
      const Radius.circular(0),
    );

    final inner = RRect.fromRectAndRadius(
      Rect.fromCenter(
          center: center,
          width: (circleRadius * 2),
          height: (circleRadius * 2)),
      Radius.circular(circleRadius),
    );
    canvas.drawDRRect(outer, inner, backgroundPaint);

    canvas.drawCircle(center, (circleRadius - strokeWidth / 2), progressBackgroundPaint);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: (circleRadius - strokeWidth / 2)),
      startAngle,
      progressAngel,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => this != oldDelegate;
}
