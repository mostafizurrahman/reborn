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
}

final ScreenData screenData = ScreenData();
