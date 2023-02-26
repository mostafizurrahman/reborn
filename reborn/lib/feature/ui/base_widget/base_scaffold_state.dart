import 'package:flutter/material.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/screen_data.dart';

class BaseScaffoldState extends StatelessWidget {
  final Widget? body;
  final Widget? bottom;
  final Widget? floating;
  final Widget? drawer;
  final PreferredSizeWidget? appBar;
  final FloatingActionButtonLocation? floatLocation;

  const BaseScaffoldState({
    Key? key,
    this.body,
    this.bottom,
    this.floating,
    this.floatLocation,
    this.appBar,
    this.drawer,
  }) : super(key: key);

  Future<bool> onWilPop() async {
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWilPop,
      child: Scaffold(
        extendBody:true,
        extendBodyBehindAppBar : true,
        drawer: drawer,
        appBar: appBar,
        body: Container(
          width: screenData.width,
          height: screenData.height,
          decoration: rebornTheme.decoration,
          child: body ?? Container(),
        ),
        bottomNavigationBar: bottom,
        floatingActionButton: floating,
        floatingActionButtonLocation: floatLocation,
      ),
    );
  }


}
