

import 'package:reborn/feature/data_model/base/base_state.dart';
import 'package:reborn/utility/app_enum.dart';
import 'package:flutter/cupertino.dart';

@immutable
class ContactEntryState extends CCBaseState {

}
class ContactEntryInitState extends ContactEntryState {
  final SecretTapType tapType;
  ContactEntryInitState({required this.tapType});
}

class ContactAddFieldState extends ContactEntryState {
  final String fieldID;
  ContactAddFieldState({required this.fieldID});
}


class ContactRemoveFieldState extends ContactEntryState {
  final String fieldID;
  ContactRemoveFieldState({required this.fieldID});
}