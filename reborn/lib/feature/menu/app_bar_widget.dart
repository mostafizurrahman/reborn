import 'package:reborn/feature/widget/ink_widget.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuBar extends AppBar {
  MenuBar(
      {Key? key,
      final String? name,
      final Color? surfaceColor,
      final Color iconColor = Colors.black,
        final double height = 75,
      final double menuWidth = 60})
      : super(
    toolbarHeight: height,
      elevation: 0,
            key: key,
            backgroundColor: surfaceColor,
            leading: Builder(
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: (height - 45)/2 ),
                  child: RIButton(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      iconData: Icons.menu_rounded,
                      iconColor: iconColor,
                      dimension: 45,
                      radius: menuWidth),
                );
              },
            ),
            leadingWidth: 63,
            title: name != null ? Text(name, style: CCAppTheme.txtHL1) : null);
}
class ContactAppBar extends AppBar {

  ContactAppBar({Key? key, required VoidCallback onTapDone, required VoidCallback onBackPressed, required String title})
      : super(key: key,
    elevation: 1.0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: onBackPressed,
    ),
    title: Text(title),
    centerTitle: true,
    actions: [
      InkWidget(
        onTap: onTapDone,
        content: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            border: Border.all(color: Colors.green, width: 2),
          ),
          child: const Padding(
            padding: EdgeInsets.all(6),
            child: Icon(
              Icons.done,
              color: Colors.green,
            ),
          ),
        ),
      ),
    ],
  );
}
