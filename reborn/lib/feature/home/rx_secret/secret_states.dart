import 'package:reborn/feature/data_model/base/base_state.dart';
import 'package:reborn/feature/data_model/entity/service_entity.dart';
import 'package:reborn/utility/app_enum.dart';
import 'package:contacts_service/contacts_service.dart';

class SecretState extends CCBaseState {

}

class SecretInitState extends SecretState {

}

class SecretAddState extends SecretState {
  final List<Contact> secretList;
  final Contact secretContact;
  SecretAddState({required this.secretList, required this.secretContact});
}

class SecretRemoveState extends SecretState {
  final Contact secretContact;
  final SecretRemoveType removeType;
  final List<Contact> secretList;
  SecretRemoveState({required this.secretList, required this.secretContact, required this.removeType});
}

class SecretContactTapState extends SecretState {
  final Contact secretContact;
  SecretContactTapState({required this.secretContact});
}

class SecretHomeTapState extends SecretState {
  final SecretTapType secretTapType;
  final bool isSecret;
  SecretHomeTapState({required this.secretTapType, required this.isSecret});
}
