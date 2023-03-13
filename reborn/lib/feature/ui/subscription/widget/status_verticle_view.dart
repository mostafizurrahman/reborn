import 'package:flutter/material.dart';
import 'package:reborn/feature/ui/subscription/widget/status_painter.dart';
import 'status_content_view.dart';

class StatusVerticleView extends StatelessWidget {
  final double width;
  final SVData statusData;
  final double statusHeight;
  const StatusVerticleView({
    Key? key,
    this.width = 50,
    required this.statusHeight,
    required this.statusData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconSize = width * 0.75;
    return SizedBox(
      width: width,
      height: statusHeight,
      // decoration: CCAppTheme.shadowNoBorder,
      child: CustomPaint(
        size: Size(iconSize, statusHeight),
        painter: StatusPainter(
            circleRadius: iconSize * 0.5,
            barWidth: 12,
            status: statusData.status),
        child: Padding(
          padding: EdgeInsets.only(top: iconSize * 0.15),
          child: Align(
            alignment: Alignment.topCenter,
            child: Icon(
              statusData.iconData,
              size: iconSize,
              color: statusData.status == SVStatus.incomplete
                  ? Colors.grey
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
