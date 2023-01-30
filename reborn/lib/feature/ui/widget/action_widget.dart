

import 'package:flutter/material.dart';
import 'package:reborn/utility/app_theme_data.dart';

class ActionWidget extends StatelessWidget {
  final Function? onTap;
  const ActionWidget({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        child: InkWell(
          focusColor: CCAppTheme.pinkLightColor.withAlpha(80),
          splashColor: CCAppTheme.periwinkleDarkColor.withAlpha(110),
          onTap: () {
            final tap = onTap;
            if (tap != null) {
              tap();
            }
          },
        ),
      ),
    );
  }
}