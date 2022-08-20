import 'package:flutter/material.dart';

class WidgetProperties {
  final double width;
  final double height;
  final double borderWidth;
  final double cornerRadius;
  final double blurRadius;
  final double splitRatio;
  final Color borderColor;
  final List<Color> gradientColorList;
  final bool isSplitWidget;
  final int itemIndex;
  WidgetProperties(
      {required this.width,
      required this.height,
      this.blurRadius = 0,
      this.cornerRadius = 0,
      this.splitRatio = 0,
      this.isSplitWidget = false,
      this.gradientColorList = const [],
      this.borderColor = Colors.black,
      this.borderWidth = 0,
      this.itemIndex = -1});
  double get topHeight {
    if (isSplitWidget) {
      return height * splitRatio;
    }
    return height;
  }

  double get bottomHeight {
    if (isSplitWidget) {
      return height * (1.0 - splitRatio);
    }
    return height;
  }
}
