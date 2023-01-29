import 'package:reborn/feature/ui/widget/blur_round_view.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/screen_data.dart';
import 'package:flutter/material.dart';

class TabBarData {
  late bool isSelected;
  final String name;
  final String tabID;
  final IconData iconData;
  final Function(String) onTap;
  TabBarData({
    required this.tabID,
    required this.name,
    required this.iconData,
    required this.onTap,
  });
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
    final width = screenData.width / tabDataList.length;
    final List<Widget> tabList = [];
    for (final tabData in tabDataList) {
      final container = SizedBox(
        width: width,
        child: Material(
          color: tabData.isSelected
              ? Colors.grey.shade200.withAlpha(60)
              : Colors.grey.shade600.withAlpha(40),
          child: Ink(
            child: InkWell(
              focusColor: CCAppTheme.pinkLightColor,
              splashColor: CCAppTheme.periwinkleDarkColor,
              onTap: () => tabData.onTap(tabData.tabID),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _getChildrenList(tabData),
              ),
            ),
          ),
        ),
      );

      tabList.add(container);
    }
    return tabList;
  }

  List<Widget> _getChildrenList(TabBarData tabData) {
    if (tabData.isSelected) {
      return [
        const SizedBox(height: 12),
        Icon(tabData.iconData, color: CCAppTheme.pinkDarkColor, size: 22),
        const SizedBox(height: 12),
        Text(
          tabData.name,
          style: CCAppTheme.txt1.copyWith(
            color: CCAppTheme.pinkDarkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ];
    }
    return [
      const SizedBox(height: 12),
      Icon(tabData.iconData, color: Colors.black, size: 22),
      const SizedBox(height: 12),
      Text(tabData.name, style: CCAppTheme.txt),
    ];
  }
}
