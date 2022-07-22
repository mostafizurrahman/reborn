

import 'package:flutter/material.dart';

class CCAppTheme {
    static BorderRadius get borderRadius => const BorderRadius.all(Radius.circular(10));
    static TextStyle get txt => const TextStyle(fontSize: 12.0, fontFamily: 'sf_light');
    static TextStyle get txt1 => const TextStyle(fontSize: 14.0, fontFamily: 'sf_light');
    static TextStyle get txtReg => const TextStyle(fontSize: 15.0, fontFamily: "sf_reg");
    static TextStyle get txt2 => const TextStyle(fontSize: 16.0, fontFamily: 'sf_light');
    static TextStyle get txtHL3 => const  TextStyle(fontSize: 17.0, fontFamily: "sf_reg");
    static TextStyle get txtHL2 => const TextStyle(fontSize: 19.0, fontFamily: "sf_semi");
    static TextStyle get txtHL1 => const TextStyle(fontSize: 22.0, fontFamily: "sf_heavy");
    static BoxDecoration get shadowDec => BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black.withOpacity(0.5), width: 2),
        borderRadius: borderRadius,
        boxShadow: [
            BoxShadow(
                color: Colors.grey.withAlpha(100),
                spreadRadius: 2,
                blurRadius: 4,
                // changes position of shadow
            ),
        ],
    );
    static Color get primaryColor => Colors.blueAccent.shade200;
}