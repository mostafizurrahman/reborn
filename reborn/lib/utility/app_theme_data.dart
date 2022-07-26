

import 'package:flutter/material.dart';
import 'package:reborn/utility/data_manager.dart';
import 'package:rxdart/rxdart.dart';

import 'app_enum.dart';



class CCAppTheme {
    static Color get pinkLightColor => const Color(0xFFEA80FC);
    static Color get periwinkleLightColor => const Color(0xFFADEEE2);
    static Color get pinkDarkColor => const Color(0xFF7827E6);
    static Color get periwinkleDarkColor => const Color(0xFF9A9CEA);
    static const String pinkDark = "7827E6", pinkMD = "8D39EC", pinkML = "AA4FF6", pinkLight = "EA80FC";
    static const String periwinkleDark = "9A9CEA", periwinkleMD = "A2B9EE", periwinkleML = "A2DCEE", periwinkleLight = "ADEEE2";
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

    static final _rebornTheme = CCAppTheme._internal();
    factory CCAppTheme() {
        return _rebornTheme;
    }
    CCAppTheme._internal();
    final BehaviorSubject<ThemeType> _themeBehaviour = BehaviorSubject();

    Future<void> switchTheme({required final int? themeValue}) async {
        final int _themeCode = themeValue ?? await dataManager.getTheme();
        if (_themeCode != -1) {
            final type = ThemeValueType.initType(_themeCode);
            _themeBehaviour.sink.add(type);
        } else {
            _themeBehaviour.sink.add(ThemeType.light);
        }
        await dataManager.saveTheme(_themeCode);
    }

}

final rebornTheme = CCAppTheme();
