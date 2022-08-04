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
      {required this.tabID,
      required this.name,
      required this.iconData,
      required this.onTap});
}

class HomeTabWidget extends StatelessWidget {
  final List<TabBarData> tabDataList;
  const HomeTabWidget({Key? key, required this.tabDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Material(
          color: Colors.transparent,
          child: SizedBox(
            height: 80,
            width: screenData.width,
            child: Row(children: _getTapItemList()),
          ),
        ),
      ),
    );
  }

  List<Widget> _getTapItemList() {
    final _width = screenData.width / tabDataList.length;
    final List<Widget> tabList = [];
    for (final _tabData in tabDataList) {
      final _container = SizedBox(
        width: _width,
        child: Material(
          color:
              _tabData.isSelected ? Colors.grey.shade600.withAlpha(200) : Colors.grey.shade500.withAlpha(140),
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
                      color: _tabData.isSelected
                          ? CCAppTheme.pinkDarkColor
                          : Colors.black,
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
