


import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class UserInfo {
  final _deviceInfo = DeviceInfoPlugin();
  String userName = "mostafizur.rahman";
  String displayName = "Mostafizur";
  late String deviceID;
  void _setDeviceId(final String value){
    deviceID = value;
  }

  Future<String> getDeviceID() async {
    if (Platform.isIOS) {
      final iosDeviceInfo = await _deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor ?? ''; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await _deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return '';
  }

  static final _userInfo = UserInfo._internal();
  factory UserInfo() {
    _userInfo.getDeviceID().then(_userInfo._setDeviceId);
    return _userInfo;
  }
  UserInfo._internal();
}

final UserInfo userInfo = UserInfo();