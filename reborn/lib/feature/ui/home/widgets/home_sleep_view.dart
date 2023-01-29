

import 'package:flutter/material.dart';
import 'package:reborn/utility/app_theme_data.dart';

class HomeSleepView extends StatefulWidget{
  static const String path = "/home/profile";

  const HomeSleepView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeSleepState();
  }
}

class _HomeSleepState extends State<HomeSleepView>  {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: Colors.transparent,
        child: Center(child: Text("Sleep"),),
      ),
    );
  }
}