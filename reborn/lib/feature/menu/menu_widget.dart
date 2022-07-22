import 'package:reborn/feature/widget/base_widget/theme_state.dart';
import 'package:reborn/utility/image_ext.dart';
import 'package:reborn/utility/screen_data.dart';
import 'package:reborn/utility/user_info.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../widget/ink_widget.dart';
import 'menu_item_widget.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MenuState();
  }
}

class _MenuState extends ThemeState<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    final menuList = MenuData.menuItems;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: screenData.width * 0.75,
          height: screenData.height,
          color: Colors.white.withAlpha(200),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getProfileWidget(),
                Expanded(
                  child: ListView.builder(
                      itemBuilder: (final _context, final _index) {
                        final _data = menuList[_index];
                        final _imgWidget = Padding(
                            padding: const EdgeInsets.only(left: 24, right: 12),
                            child: ImageExt.get(
                                "menu_icons/${_data.iconName}.png",
                                dimension: 35));
                        return CCImageButton(
                            onTap: () => _onTapMenu(data: _data),
                            title: _data.titleKey.toUpperCase(),
                            isRowButton: true,
                            dimension: screenData.width * 0.75,
                            height: 55,
                            imageWidget: _imgWidget);
                      },
                      itemCount: menuList.length,
                      scrollDirection: Axis.vertical),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapMenu({required final MenuData data}) {}

  Widget _getProfileWidget() {
    return SizedBox(
      height: 110,
      child: Padding(
        padding: const EdgeInsets.only(left: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      const Text("HELLO!"),
                      const SizedBox(height: 12),
                      Text(userInfo.displayName, style: headStyle1),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  width: 60,
                  color: Colors.pinkAccent.shade200,
                ),
                const SizedBox(width: 16),
              ],
            ),
            Divider(height: 5, color: appColor)
          ],
        ),
      ),
    );
  }
}
