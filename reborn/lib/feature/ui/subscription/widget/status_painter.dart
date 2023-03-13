
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'status_content_view.dart';


class StatusPainter extends CustomPainter {
  final double circleRadius;
  final double barWidth;
  final Color backgroundColor;
  final Color completeColor;
  final Color activeColor;
  final SVStatus status;
  final activePaint = Paint()..style = PaintingStyle.stroke;
  final backgroundPaint = Paint()..style = PaintingStyle.fill;

  StatusPainter({
    required this.circleRadius,
    required this.status,
    this.barWidth = 32,
    this.backgroundColor = Colors.grey,
    this.completeColor = Colors.greenAccent,
    this.activeColor = Colors.pinkAccent,
  });

  void _paintCircleIcon(Canvas canvas, Size size) {
    activePaint.strokeWidth = 4;
    activePaint.color = status == SVStatus.incomplete ? activeColor : completeColor;
    canvas.drawCircle(Offset(size.width / 2, size.width / 2),
        size.width / 2 - 2, activePaint);
  }

  void _paintBackground(Canvas canvas, Size size) {
    backgroundPaint.color = backgroundColor;
    canvas.drawRRect(
      RRect.fromLTRBR(0, 0, size.width, size.height, const Radius.circular(8)),
      backgroundPaint,
    );
  }

  void _paintLineGradient(Canvas canvas, Size size) {
    final gradientHeight = size.height - size.width;
    if (status == SVStatus.active) {
      backgroundPaint.shader = ui.Gradient.linear(
        Offset(0, size.width + 8),
        Offset(0, size.width + gradientHeight * 0.6),
        [completeColor, activeColor],
      );
    } else if (status == SVStatus.incomplete) {
      backgroundPaint.color = Colors.grey;
    } else {
      backgroundPaint.color = completeColor;
    }
    final orgX = size.width / 2 - barWidth / 2;
    canvas.drawRRect(
      RRect.fromLTRBR(
        orgX,
        size.width + 8,
        orgX + barWidth,
        size.height - barWidth / 2,
        Radius.circular(barWidth / 2),
      ),
      backgroundPaint,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    // _paintBackground(canvas, size);
    _paintLineGradient(canvas, size);
    _paintCircleIcon(canvas, size);

    // const icon = Icons.check_circle_outline;
    // var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
    //   fontFamily: icon.fontFamily,
    //   fontSize: 35,
    //
    // ))
    //   ..addText(String.fromCharCode(icon.codePoint));
    // var para = builder.build();
    // para.layout(const ui.ParagraphConstraints(width: 60));
    // canvas.drawParagraph(para, const Offset(0, 0));

    // final centerX = size.width / 2;
    // final centerY = circleRadius + topSpacing;
    // final center = Offset(centerX, centerY);
    //
    // const startAngle = (270 * pi) / 180;
    // const totalAngle = (360 * pi) / 180;
    // double progressAngel = (totalAngle * progress) / 100;
    // if (isAntiClockWiseProgress) {
    //   progressAngel = -progressAngel;
    // }
    //
    // backgroundPaint.color = backgroundColor;
    // backgroundPaint.style = PaintingStyle.fill;
    // progressBackgroundPaint
    //   ..strokeWidth = strokeWidth
    //   ..color = progressBackgroundColor;
    // progressPaint
    //   ..strokeWidth = strokeWidth
    //   ..strokeCap = StrokeCap.round
    //   ..color = progressColor;
    //
    // final outer = RRect.fromLTRBR(
    //   0,
    //   0,
    //   size.width,
    //   size.height,
    //   const Radius.circular(0),
    // );
    //
    // final inner = RRect.fromRectAndRadius(
    //   Rect.fromCenter(
    //       center: center,
    //       width: (circleRadius * 2),
    //       height: (circleRadius * 2)),
    //   Radius.circular(circleRadius),
    // );
    // canvas.drawDRRect(outer, inner, backgroundPaint);
    //
    // canvas.drawCircle(center, (circleRadius - strokeWidth / 2), progressBackgroundPaint);
    //
    // canvas.drawArc(
    //   Rect.fromCircle(center: center, radius: (circleRadius - strokeWidth / 2)),
    //   startAngle,
    //   progressAngel,
    //   false,
    //   progressPaint,
    // );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => this != oldDelegate;
}
