import 'dart:math';

import 'package:flutter/material.dart';

class ImageExt {
  static AssetImage getImageAsset(String name) {
    return AssetImage('lib/assets/$name');
  }

  static Image get(final String name,
      {final double dimension = 40,
      final BoxFit fit = BoxFit.fitWidth,
      final bool isSquare = false}) {
    return Image(
      image: getImageAsset(name),
      width: dimension,
      fit: BoxFit.fitWidth,
    );
  }

  static Color get randomColor {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }
}
