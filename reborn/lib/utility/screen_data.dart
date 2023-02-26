import 'package:flutter/material.dart';

class ScreenData {
  late final Size _size;
  late final double _top;
  late final double _bottom;
  Size get size => _size;
  double get width => _size.width;
  double get height => _size.height;
  double get top => _top;
  double get bottom => _bottom;
  bool isInit = false;
  void setScreenData(final BuildContext context) {
    if (!isInit) {
      isInit = true;
      _size = MediaQuery.of(context).size;
      _top =  MediaQuery.of(context).padding.top;
      _bottom = MediaQuery.of(context).padding.bottom;
      debugPrint("done");
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

class HorizontalScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

final ScreenData screenData = ScreenData();
