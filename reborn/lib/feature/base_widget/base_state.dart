import 'package:flutter/material.dart';

abstract class BaseScaffoldState<T extends StatefulWidget>
    extends State<T>{
  Future<bool> onWilPop() async {
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(child: Scaffold(), onWillPop: onWilPop);
  }
}
