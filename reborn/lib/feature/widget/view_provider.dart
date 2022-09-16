



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewProvider {
  static const String iconFontPackage = 'cupertino_icons';
  static const String iconFont = 'CupertinoIcons';
  static Icon getCupertinoIcon({required final int iconValue, final Color color = Colors.black54, final double iconSize = 24,}) {
    IconData iconData = IconData(iconValue, fontFamily: iconFont, fontPackage: iconFontPackage);
    return Icon(iconData, color: color, size: iconSize,);
  }

}