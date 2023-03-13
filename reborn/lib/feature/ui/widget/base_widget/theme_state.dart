


import 'package:reborn/utility/app_theme_data.dart';
import 'package:flutter/material.dart';

class ThemeState<T extends StatefulWidget> extends State<T> {

  BoxDecoration get shadowBorder => CCAppTheme.shadowDec;
  TextTheme get txtTheme => Theme.of(context).textTheme;
  TextStyle get textStyle => txtTheme.bodyText1 ?? CCAppTheme.txt ;
  TextStyle get bodyText2 => txtTheme.bodyText2 ?? CCAppTheme.txt1 ;
  TextStyle get textStyle2 => txtTheme.bodyText2 ?? CCAppTheme.txt2 ;
  TextStyle get headStyle3 => txtTheme.headline3 ?? CCAppTheme.txtHL3 ;
  TextStyle get headStyle2 => txtTheme.headline2 ?? CCAppTheme.txtHL2 ;
  TextStyle get headStyle1 => txtTheme.headline1 ?? CCAppTheme.txtHL1 ;
  Color get appColor => CCAppTheme.primaryColor;

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }

}