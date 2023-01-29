import 'package:reborn/routing/app_route.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/image_ext.dart';
import 'package:reborn/utility/screen_data.dart';
import 'package:flutter/material.dart';

class HomeGridWidget extends StatelessWidget {
  final Function(String) onGridTap;
  const HomeGridWidget({Key? key, required this.onGridTap}) : super(key: key);
  BorderRadius get _radiusTL => const BorderRadius.only(topLeft: Radius.circular(9));
  BorderRadius get _radiusTR => const BorderRadius.only(topRight: Radius.circular(9));
  BorderRadius get _radiusBL => const BorderRadius.only(bottomLeft: Radius.circular(9));
  BorderRadius get _radiusBR => const BorderRadius.only(bottomRight: Radius.circular(9));
  @override
  Widget build(BuildContext context) {
    final width = screenData.width - 32;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text("MANAGE  CONTACTS", style: CCAppTheme.txtHL2),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: CCAppTheme.shadowDec,
            width: width + 4,
            height: width / 2 + 3,
            child: Column(
              children: [
                Row(
                  children: [
                    _getTapWidget("CREATE", Icons.person_add_alt_1, AppRoutes.entry, _radiusTL),
                    const VerticalDivider(width: 2),
                    _getTapWidget("DUPLICATE", Icons.stream, AppRoutes.duplicate, _radiusTR),
                  ],
                ),
                const Divider(height: 2),
                Row(
                  children: [
                    _getTapWidget("RECENT", Icons.recent_actors, AppRoutes.recent, _radiusBL),
                    const VerticalDivider(width: 2),
                    _getTapWidget("VAULT", Icons.stream, AppRoutes.vault, _radiusBR),
                  ],
                ),
              ],
            ),
          )
          // contactList.isEmpty ? _getMaterialTapWidget(_widget, onTapParent) : _widget,
        ],
      ),
    );
  }

  Widget _getTapWidget(
      final String title, final IconData iconData, String route, final BorderRadius radius) {
    final dimension = (screenData.width - 38) / 2;
    return Material(
      borderRadius: radius,
      color: Colors.transparent,
      child: Ink(
        child: InkWell(
          borderRadius: radius,
          focusColor: Colors.blue,
          splashColor: Colors.blueAccent,
          onTap: () => onGridTap(route),
          child: Container(
            width: dimension,
            height: dimension / 2,
            decoration: BoxDecoration(color: Colors.grey.withAlpha(100), borderRadius: radius),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(iconData, color: ImageExt.randomColor, size: 40),
                const SizedBox(height: 8),
                Text(title, style: CCAppTheme.txtHL1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
