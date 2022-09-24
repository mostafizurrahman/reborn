import 'dart:math';

import 'package:flutter/material.dart';

class ImageExt {
  static AssetImage getImageAsset(String name) {
    if (name.contains("lib")) {
      return AssetImage(name);
    }
    return AssetImage('lib/assets/$name');
  }

  static Image get(
    final String name, {
    final double widgetWidth = 40,
        final double widgetHeight = 40,
    final BoxFit fit = BoxFit.cover,
  }) {
    return Image(
      image: getImageAsset(name),
      width: widgetWidth,
      height: widgetHeight,
      fit: fit,
    );
  }

  static Color get randomColor {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  static Image getDefaultCover({
    required final width,
    required final double height,
  }) {
    return Image(
      image: getImageAsset("default_cover.jpg"),
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }

  static Image getDefaultGrid({
    required final width,
    required final double height,
  }) {
    return Image(
      image: getImageAsset("default_grid.jpg"),
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}
