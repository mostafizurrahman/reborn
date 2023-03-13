import 'dart:io';
import 'package:flutter/services.dart';
import 'package:reborn/feature/data_model/sqlite_manager.dart';
import 'package:reborn/feature/ui/audio_player/audio_player_screen.dart';
import 'package:reborn/feature/ui/contact_add/contact_entry_widget.dart';
import 'package:reborn/feature/ui/contact_list/contact_list_widget.dart';
import 'package:reborn/feature/ui/home/home_widget.dart';
import 'package:reborn/feature/ui/startup/launch_widget.dart';
import 'package:reborn/feature/ui/startup_page.dart';
import 'package:reborn/feature/ui/subscription/subscription_page.dart';
import 'package:reborn/feature/ui/track_list/track_list_page.dart';
import 'package:reborn/routing/app_route.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:reborn/utility/user_info.dart';
import 'feature/firebase/firebase_handler.dart';
import 'firebase_options.dart';
import 'utility/app_theme_data.dart';

void main() async {
  runApp(const MainAppWidget());
}

class MainAppWidget extends StatefulWidget {
  const MainAppWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainAppState();
  }
}

class MainAppState extends State<MainAppWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    /*
    theme: ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.dark,
    primaryColor: Colors.lightBlue[800],

    // Define the default font family.
    fontFamily: 'Georgia',

    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
  )

  (headline1 == null && headline2 == null && headline3 == null && headline4 == null &&
             headline5 == null && headline6 == null && subtitle1 == null && subtitle2 == null &&
             bodyText1 == null && bodyText2 == null && caption == null && button == null && overline == null)
     */
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.grey.shade200,
        primaryColor: Colors.blueAccent,
        shadowColor: const Color.fromARGB(150, 200, 200, 200),
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white.withAlpha(200),
          titleTextStyle: const TextStyle(
              fontSize: 18.0, fontFamily: "sf_semi", color: Colors.black),
        ),
        textTheme: TextTheme(
          headline1: CCAppTheme.txtHL1,
          headline2: CCAppTheme.txtHL2,
          headline3: CCAppTheme.txtHL3,
          bodyText2: CCAppTheme.txt2,
          bodyText1: CCAppTheme.txt1,
          caption: CCAppTheme.txtReg,
          // titleSmall: const TextStyle(fontSize: 15.0, fontFamily: "sf_reg"),
          // titleMedium: const TextStyle(fontSize: 17.0, fontFamily: "sf_semi"),
          // titleLarge: const TextStyle(fontSize: 18.0, fontFamily: "sf_heavy"),
        ),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SubscriptionPage(),
      onGenerateRoute: _getGenerateRoute,
    );
  }

  Route _getGenerateRoute(RouteSettings settings) {
    Widget widget = const SizedBox();
    if ((settings.name == AppRoutes.home)) {
      widget = const HomeWidget();
    } else if (settings.name == AppRoutes.list) {
      widget = ContactListWidget(args: settings.arguments);
    } else if (settings.name == AppRoutes.entry) {
      widget = ContactEntryWidget(args: settings.arguments);
    } else if (settings.name == TrackListPage.path) {
      final summary = TrackListPage.getSummary(settings.arguments as Map);
      widget = TrackListPage(summary: summary);
    } else if (settings.name == AudioPlayerScreen.path) {
      final track = AudioPlayerScreen.getTrack(settings.arguments as Map);
      widget = AudioPlayerScreen(track: track);
    }

    if (Platform.isIOS) {
      return MaterialPageRoute(
        builder: (context) {
          return WillPopScope(
            onWillPop: () => _onPop(context),
            child: widget,
          );
        },
        settings:
            RouteSettings(name: settings.name, arguments: settings.arguments),
      );
    }
    return AppRoutes.createRoute(settings, widget);
  }

  Future<bool> _onPop(BuildContext context) async {
    if (Navigator.of(context).userGestureInProgress) {
      return Future<bool>.value(false);
    }
    return Future<bool>.value(true);
  }
}
