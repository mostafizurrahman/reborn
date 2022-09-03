// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB2rgX7DsDarBbfZAlk8r2yGCBShtqPoco',
    appId: '1:840943017720:android:69a472718594712cee650d',
    messagingSenderId: '840943017720',
    projectId: 'reborn-1b03e',
    storageBucket: 'reborn-1b03e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAT4S5vQDFyc6RZZs4JUICNLLSmkcjsP74',
    appId: '1:840943017720:ios:90608f767715657dee650d',
    messagingSenderId: '840943017720',
    projectId: 'reborn-1b03e',
    storageBucket: 'reborn-1b03e.appspot.com',
    androidClientId: '840943017720-rfiapa870151qnkdm88vh9lbl47jl1ft.apps.googleusercontent.com',
    iosClientId: '840943017720-8o8es85dpbo4ej73c1sr9ndp4cs8h12f.apps.googleusercontent.com',
    iosBundleId: 'com.reborn.reborn',
  );
}
