import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reborn/utility/app_theme_data.dart';

class ViewProvider {
  static const String iconFontPackage = 'cupertino_icons';
  static const String iconFont = 'CupertinoIcons';
  static Icon getCupertinoIcon({
    required final int iconValue,
    final Color color = Colors.black54,
    final double iconSize = 24,
  }) {
    IconData iconData = IconData(iconValue, fontFamily: iconFont, fontPackage: 'cupertino_icons');
    return Icon(
      iconData,
      color: color,
      size: iconSize,
    );
  }

  static Widget backButton(final BuildContext context, {VoidCallback? onBack}) {
    return Material(
      color: Colors.transparent,
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      child: Ink(
        decoration: CCAppTheme.trackDecoration,
        width: 40,
        height: 40,
        child: InkWell(

          onTap: () {
            if (onBack != null) {
              onBack();
            } else {
              Navigator.of(context).pop();
            }
          },
          child: const Center(
            child: Icon(CupertinoIcons.arrow_left_circle,size: 35,),
          ),
        ),
      ),
    );
  }
}
