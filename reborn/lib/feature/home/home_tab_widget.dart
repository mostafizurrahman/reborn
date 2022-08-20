import 'package:reborn/feature/widget/blur_round_view.dart';
import 'package:reborn/utility/screen_data.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../../utility/app_theme_data.dart';

class TabBarData {
  late bool isSelected;
  final String name;
  final String tabID;
  final IconData iconData;
  final Function(String) onTap;
  TabBarData(
      {required this.tabID, required this.name, required this.iconData, required this.onTap});
}

class HomeTabWidget extends StatelessWidget {
  final List<TabBarData> tabDataList;
  const HomeTabWidget({Key? key, required this.tabDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlurRoundView(
      content: Row(children: _getTapItemList()),
      viewHeight: 80.0,
      radius: rebornTheme.topRound,
    );
  }

  List<Widget> _getTapItemList() {
    final _width = screenData.width / tabDataList.length;
    final List<Widget> tabList = [];
    for (final _tabData in tabDataList) {
      final _container = SizedBox(
        width: _width,
        child: Material(
          color: _tabData.isSelected
              ? Colors.grey.shade600.withAlpha(200)
              : Colors.grey.shade500.withAlpha(140),
          child: Ink(
            child: InkWell(
              focusColor: CCAppTheme.pinkLightColor,
              splashColor: CCAppTheme.periwinkleDarkColor,
              onTap: () => _tabData.onTap(_tabData.tabID),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 12),
                  Icon(_tabData.iconData,
                      color: _tabData.isSelected ? CCAppTheme.pinkDarkColor : Colors.black,
                      size: 22),
                  const SizedBox(height: 12),
                  Text(_tabData.name, style: CCAppTheme.txt),
                ],
              ),
            ),
          ),
        ),
      );

      tabList.add(_container);
    }
    return tabList;
  }
}
