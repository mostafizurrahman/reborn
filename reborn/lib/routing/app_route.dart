


import 'package:flutter/material.dart';

class AppRoutes {

  static String get trackList => "/home/tracks";






  static String get settings => "settings";
  static String get account => "account";
  static String get help => "help";
  static String get inbox => "inbox";
  static String get home => "home";
  static String get orders => "orders";
  static String get profile => "$home/profile";
  static String get entry => "$home/$list/entry";
  static String get list => "$home/contact_list";
  static String get details  => "$home/$list/contact_details";

  static String get duplicate  => "$home/duplicate";
  static String get recent  => "$home/recent_log";
  static String get vault  => "$home/vault";

  static Route createRoute(final RouteSettings _settings, final _widget) {
    return PageRouteBuilder(
      settings: _settings,
      pageBuilder: (context, animation, secondaryAnimation) => _widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}