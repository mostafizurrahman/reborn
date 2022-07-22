

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AppChannel {
  static String get iosChannel => "com.contacts.ios";
  static String get iosContactPermission => "getContactPermission";
  static String get iOSRequestPermission => "requestContactPermission";
  static String get iOSOpenSettings => "openSettings";

  final _iosChannel = _IOSChannel();
  Future<bool> checkIOSContactPermission() async {
    return await _iosChannel._checkIOSContactPermission();
  }
  Future<bool> requestIOSContactPermission() async {
    return await _iosChannel._requestIOSContactPermission();
  }
  void openIOSSettings() {
    _iosChannel._openIOSAppSettings();
  }
}

class _IOSChannel {
  final iosPlatform = MethodChannel(AppChannel.iosChannel);
  void _onError(error, stackTrace) {
    debugPrint("error $error and stack-trace $stackTrace");
  }
  Future<bool> _checkIOSContactPermission() async {
    final _data = await iosPlatform
        .invokeMethod(AppChannel.iosContactPermission)
        .onError(_onError);
    final _map = _data as Map?;
    return _map?["_contact_permission_"] ?? false;
  }

  Future<bool> _requestIOSContactPermission() async {
    final _data = await iosPlatform
        .invokeMethod(AppChannel.iOSRequestPermission)
        .onError(_onError);
    final _map = _data as Map?;
    return _map?["_contact_permission_"] ?? false;
  }

  void _openIOSAppSettings() {
    final iosPlatform = MethodChannel(AppChannel.iosChannel);
    iosPlatform.invokeMethod(AppChannel.iOSOpenSettings).onError(_onError);
  }

}