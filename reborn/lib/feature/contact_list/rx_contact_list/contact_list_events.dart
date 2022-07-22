


import 'package:reborn/feature/data_model/base/base_event.dart';
import 'package:reborn/feature/data_model/entity/service_entity.dart';
import 'package:reborn/utility/app_enum.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactListEvent extends CCBaseEvent {

}


class ContactListIniEvent extends ContactListEvent {
  final SecretTapType tapType;
  ContactListIniEvent({required this.tapType, });
}

class ContactListTapEvent extends ContactListEvent {
  final Contact contact;
  ContactListTapEvent({required this.contact});
}

class ContactListSwipeEvent extends ContactListEvent {
  final Contact contact;
  ContactListSwipeEvent({required this.contact});
}

class ContactListDeleteEvent extends ContactListEvent {
  final Contact contact;
  ContactListDeleteEvent({required this.contact});
}

