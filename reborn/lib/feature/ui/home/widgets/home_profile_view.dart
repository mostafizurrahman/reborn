

import 'package:flutter/material.dart';
import 'package:reborn/utility/app_theme_data.dart';

class HomeProfileView extends StatefulWidget{
  static const String path = "/home/profile";

  const HomeProfileView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeProfileState();
  }
}

class _HomeProfileState extends State<HomeProfileView>  {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: CCAppTheme.shadowDec,
        child: Center(child: Text("PROFILE"),),
      ),
    );
  }
}