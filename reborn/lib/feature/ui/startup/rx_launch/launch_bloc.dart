import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reborn/feature/ui/startup/rx_launch/launch_events.dart';
import 'package:reborn/feature/ui/startup/rx_launch/launch_states.dart';
import 'package:reborn/utility/app_channel.dart';




class LauncherBloc extends Bloc<LaunchEvent, LaunchState> {
  LauncherBloc() : super(LaunchState()) {
    on<LaunchEvent>((event, emit) => emit(LaunchState()));
    on<ReadContactEvent>(_onReadContacts);
    on<PermissionRequestEvent>(_onRequestPermission);
    on<ContactPermissionEvent>(_onCheckContactPermission);
  }

  Future<PermissionStatus> get _contactPermissionStatus async {
    if (Platform.isIOS) {
      final iOSChannel = AppChannel();
      return await iOSChannel.checkIOSContactPermission()
          ? PermissionStatus.granted
          : PermissionStatus.denied;
    }
    return await Permission.contacts.status;
  }

  Future<PermissionStatus> get _contactRequestStatus async {
    if (Platform.isIOS) {
      final iOSChannel = AppChannel();
      return await iOSChannel.requestIOSContactPermission()
          ? PermissionStatus.granted
          : PermissionStatus.denied;
    }
    return await Permission.contacts.request();
  }

  Future<void> _onCheckContactPermission(final ContactPermissionEvent event,
      final Emitter<LaunchState> emit) async {
    emit(LoadingLaunchState());
    final status = await _contactPermissionStatus;
    final state = ContactPermissionState(permissionStatus: status);
    emit(state);
  }

  Future<void> _onRequestPermission(final PermissionRequestEvent event,
      final Emitter<LaunchState> emit) async {
    if (this.state is! LoadingLaunchState) {
      emit(LoadingLaunchState());
    }
    final status = await _contactRequestStatus ;
    final state = PermissionRequestState(permissionStatus: status);
    emit(state);
  }

  Future<void> _onReadContacts(
      final ReadContactEvent event, final Emitter<LaunchState> emit) async {
    emit(LoadingContactState());
    await Future.delayed(const Duration(seconds: 1));

    // await contactService.getContactList();
    // await sqlDatabase.finish();
    emit(ReadContactState());
  }
}
