import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:reborn/feature/data_model/sqlite_manager.dart';
import 'package:reborn/feature/firebase/firebase_handler.dart';
import 'package:reborn/feature/ui/base_widget/base_scaffold_state.dart';
import 'package:reborn/firebase_options.dart';
import 'package:reborn/utility/screen_data.dart';
import 'package:reborn/utility/user_info.dart';
import 'package:rxdart/rxdart.dart';

import 'startup/launch_widget.dart';
import 'widget/loader/loading_view.dart';

class StartupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StartupState();
  }
}

class _StartupState extends State<StartupPage> {
  final BehaviorSubject<bool> loadHome = BehaviorSubject.seeded(false);

  @override
  void initState() {
    super.initState();
    _setFirebase();
  }

  void _setFirebase() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform).onError(_onFireError);
    sqlDatabase.createDatabase().then(_onCreateDataBase).catchError(_onError);
  }

  FutureOr<FirebaseApp> _onFireError(_, __) {
    loadHome.sink.add(true);
    return Firebase.apps.first;
  }

  void _onError(_) {
    loadHome.sink.add(true);
  }

  void _onCreateDataBase(_) {
    userInfo.getDeviceID().then(setDeviceID);
  }

  void setDeviceID(final String did) {
    firebase.listenFirebase(did);
    loadHome.sink.add(true);
  }

  @override
  Widget build(BuildContext context) {

    screenData.setScreenData(context);
    return StreamBuilder(
      builder: (BuildContext ctx, AsyncSnapshot<bool> data) {
        if (data.data == true) {
          return BaseScaffoldState(
            body: defaultLoader,
          );
        }
        return const LaunchWidget();
      },
    );
  }
}
