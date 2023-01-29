import 'package:reborn/feature/data_model/base/base_event.dart';
import 'package:flutter/cupertino.dart';

@immutable
class ContactEntryEvent extends CCBaseEvent {

}

class ContactAddFieldEvent extends ContactEntryEvent {
  final String fieldID;
  final String labelName;
  ContactAddFieldEvent({required this.fieldID, required this.labelName});
}

class ContactRemoveFieldEvent extends ContactEntryEvent {
  final String fieldID;
  ContactRemoveFieldEvent({required this.fieldID});
}