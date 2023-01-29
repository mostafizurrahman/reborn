

import 'package:reborn/routing/app_route.dart';
import 'package:reborn/utility/image_ext.dart';
import 'package:reborn/utility/screen_data.dart';
import 'package:flutter/material.dart';

class MenuData {
  Map<String, dynamic>? arguments;
  final bool shouldVisible;
  final String titleKey, iconName, menuID, route;
  final IconData? iconData;
  // String get title => appTranslator.text(titleKey, FN: AL.LN_SETTING);
  MenuData(
      {required this.route,
        required this.menuID,
        required this.titleKey,
        required this.iconName,
        this.arguments,
        this.iconData,
        this.shouldVisible = true});


  static List<MenuData> menuItems = [

    MenuData(
      menuID: "id_home",
      route: AppRoutes.home,
      iconName: 'ic_home',
      titleKey: 'home',
    ),

    MenuData(
      menuID: "id_orders",
      route: AppRoutes.orders,
      iconName: 'ic_orders',
      titleKey: 'Subscription',
    ),
    MenuData(
      menuID: "id_account",
      route: AppRoutes.account,
      iconName: 'ic_account',
      titleKey: 'account',
    ),
    MenuData(
      menuID: "id_help",
      route: AppRoutes.help,
      iconName: 'ic_help',
      titleKey: 'help',
    ),
    MenuData(
      menuID: "id_inbox",
      route: AppRoutes.inbox,
      iconName: 'ic_inbox',
      titleKey: 'inbox',
    ),
    MenuData(
      menuID: "id_settings",
      route: AppRoutes.settings,
      iconName: 'ic_settings',
      titleKey: 'settings',
    ),
    MenuData(
      menuID: "id_logout",
      route: "",
      iconName: 'ic_logout',
      titleKey: 'logout',
    ),
  ];
}

class MenuItemWidget extends StatelessWidget {

  final MenuData menuData;
  const MenuItemWidget({Key? key, required this.menuData}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: screenData.width,
        child: Column(
          children: [
            Row(
              children: [
                Padding(padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ImageExt.get(menuData.iconName),
                ),
                Text(menuData.titleKey),
              ],
            ),
            const Divider(height: 0.75)
          ],
        ),
      ),
    );
  }
}