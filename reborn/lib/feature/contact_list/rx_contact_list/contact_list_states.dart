
import 'package:reborn/feature/data_model/base/base_state.dart';
import 'package:reborn/feature/data_model/entity/service_entity.dart';
import 'package:reborn/utility/app_enum.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactListState extends CCBaseState {

}

class ContactListInitState extends ContactListState {
  final SecretTapType tapType;
  ContactListInitState({required this.tapType});
}

class ContactListSwipeState extends ContactListState {
  final Contact contact;
  ContactListSwipeState({required this.contact});
}

class ContactListDeleteState extends ContactListState {
  final Contact contact;
  ContactListDeleteState({required this.contact});
}


class ContactListTapState extends ContactListState {
  final Contact contact;
  ContactListTapState({required this.contact});
}