


import 'package:reborn/feature/data_model/base/base_state.dart';
import 'package:permission_handler/permission_handler.dart';

class LaunchState extends CCBaseState {

}

class LoadingLaunchState extends LaunchState {
  LoadingLaunchState();
}

class LoadingContactState extends LaunchState {

}

class ContactPermissionState extends LaunchState {

  final PermissionStatus permissionStatus;
  ContactPermissionState({required this.permissionStatus});
}

class ReadContactState extends LaunchState {

}

class PermissionRequestState extends LaunchState {
  final PermissionStatus permissionStatus;
  PermissionRequestState({required this.permissionStatus});
}

