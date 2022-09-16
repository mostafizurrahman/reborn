import 'package:flutter/material.dart';

class ScreenData {
  late final Size _size;
  Size get size => _size;
  double get width => _size.width;
  double get height => _size.height;
  bool isInit = false;
  void setScreenData(final BuildContext context) {
    if (!isInit) {
      isInit = true;
      _size = MediaQuery.of(context).size;
    }
  }

  EdgeInsets getHorizontalPadding(final int listLen, final int listIndex) {
    if (listIndex == 0) {
      return const EdgeInsets.only(left: 24, right: 8, top: 8, bottom: 8);
    }
    if (listIndex == listLen - 1) {
      return const EdgeInsets.only(right: 24, top: 8, bottom: 8);
    }
    return const EdgeInsets.all(8);
  }

  EdgeInsets getHomeVerticalPadding(final int listLen, final int listIndex) {
    if (listIndex == 0) {
      return const EdgeInsets.only(top: 16, bottom: 16);
    }
    if (listIndex == listLen - 1) {
      return const EdgeInsets.only(bottom: 88);
    }
    return const EdgeInsets.only(bottom: 16, top: 3);
  }
}

final ScreenData screenData = ScreenData();
