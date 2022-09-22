import 'package:flutter/material.dart';
import 'package:reborn/utility/data_manager.dart';
import 'package:rxdart/rxdart.dart';

import 'app_enum.dart';

class CCAppTheme {
  bool get isDark {
    if (_themeBehaviour.hasValue) {
      return _themeBehaviour.value == ThemeType.dark;
    }
    return false;
  }


  BorderRadius get topRound{
    return const BorderRadius.only(
      topLeft: Radius.circular(7),
      topRight: Radius.circular(7),
    );
  }

  BorderRadius get bottomRound{
    return const BorderRadius.only(
      topLeft: Radius.circular(7),
      topRight: Radius.circular(7),
    );
  }

  static Color get pinkDarkerColor => const Color(0xFF7827E6);
  static Color get pinkMediumColor => const Color(0xFFAA4FF6);
  static Color get pinkLightColor => const Color(0xFFEA80FC);
  static Color get periwinkleLightColor => const Color(0xFFADEEE2);
  static Color get pinkDarkColor => const Color(0xFF8D39EC);
  static Color get periwinkleDarkColor => const Color(0xFF9A9CEA);
  static const String pinkDark = "7827E6",
      pinkMD = "8D39EC",
      pinkML = "AA4FF6",
      pinkLight = "EA80FC";
  static const String periwinkleDark = "9A9CEA",
      periwinkleMD = "A2B9EE",
      periwinkleML = "A2DCEE",
      periwinkleLight = "ADEEE2";

  Color get txtColor {
    if (isDark) {
      return Colors.grey.shade300;
    }
    return Colors.black;
  }

  Color get background {
    if (_themeBehaviour.value == ThemeType.dark) {
      return pinkDarkerColor;
    }
    return periwinkleLightColor;
  }

  Color get foreground {
    if (_themeBehaviour.value == ThemeType.dark) {
      return pinkLightColor;
    }
    return periwinkleLightColor;
  }

  static BorderRadius get borderRadius => const BorderRadius.all(Radius.circular(10));
  static TextStyle get txt => TextStyle(
        fontSize: 12.0,
        fontFamily: 'sf_light',
        color: rebornTheme.txtColor,
      );
  static TextStyle get txt1 => TextStyle(
        fontSize: 14.0,
        fontFamily: 'sf_light',
        color: rebornTheme.txtColor,
      );
  static TextStyle get txtReg => TextStyle(
        fontSize: 15.0,
        fontFamily: "sf_reg",
        color: rebornTheme.txtColor,
      );
  static TextStyle get txt2 => TextStyle(
        fontSize: 16.0,
        fontFamily: 'sf_light',
        color: rebornTheme.txtColor,
      );
  static TextStyle get txtHL3 => TextStyle(
        fontSize: 17.0,
        fontFamily: "sf_reg",
        color: rebornTheme.txtColor,
      );
  static TextStyle get txtHL2 => TextStyle(
        fontSize: 19.0,
        fontFamily: "sf_semi",
        color: rebornTheme.txtColor,
      );
  static TextStyle get txtHL1 => TextStyle(
        fontSize: 22.0,
        fontFamily: "sf_heavy",
        color: rebornTheme.txtColor,
      );
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

  static BoxDecoration get circleBorderDec => BoxDecoration(
    color: Colors.transparent,
    border: Border.all(color: CCAppTheme.periwinkleDarkColor, width: 1.5),
    borderRadius: const BorderRadius.all(Radius.circular(1000)),
  );

  static BoxDecoration get shadowNoBorder => BoxDecoration(
        color: Colors.white.withAlpha(200),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(120),
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
    if (themeValue == null) {
      await dataManager.saveTheme(_themeCode);
    }
  }

  Future<void> onThemeRead() async {
    if (DateTime.now().hour > 12) {
      switchTheme(themeValue: 1);
    } else {
      switchTheme(themeValue: 0);
    }
  }

  Future<void> switchDefault() async {
    await dataManager.clearTheme();
    onThemeRead();
  }

  void dispose() {
    _themeBehaviour.close();
  }

  BoxDecoration get decoration {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage(isDark ? "lib/assets/bg_dark.jpg" : "lib/assets/bg_light.jpg"),
        fit: BoxFit.cover,
      ),
    );
  }
}

final rebornTheme = CCAppTheme();
