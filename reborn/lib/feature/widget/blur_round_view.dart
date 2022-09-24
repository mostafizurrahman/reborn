import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:reborn/utility/screen_data.dart';

class BlurRoundView extends StatelessWidget {

  final Widget content;
  final double viewHeight;
  final BorderRadius radius;
  final Color color;
  const BlurRoundView({
    Key? key,
    required this.content,
    this.viewHeight = 80,
    required this.radius,
    this.color = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Material(
          color: color,
          child: SizedBox(
            height: viewHeight,
            width: screenData.width,
            child: content,
          ),
        ),
      ),
    );
  }
}
