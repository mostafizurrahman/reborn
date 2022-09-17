

import 'package:flutter/material.dart';
import 'package:reborn/utility/app_theme_data.dart';

class HomeFavoriteView extends StatefulWidget{
  static const String path = "/home/profile";

  const HomeFavoriteView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeFavoriteState();
  }
}

class _HomeFavoriteState extends State<HomeFavoriteView>  {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: CCAppTheme.shadowDec,
        child: Center(child: Text("Favorite"),),
      ),
    );
  }
}