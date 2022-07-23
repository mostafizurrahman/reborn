



import 'package:reborn/utility/app_enum.dart';

import '../../data_model/base/base_event.dart';
import '../../data_model/entity/service_entity.dart';

class SecretEvent extends CCBaseEvent {

}

class SecretInitEvent extends SecretEvent {

}

class SecretAddEvent extends SecretEvent {
  final dynamic secretContact;
  SecretAddEvent({required this.secretContact});
}

class SecretRemoveEvent extends SecretEvent {
  final SecretRemoveType removeType;
  final dynamic secretContact;
  SecretRemoveEvent({required this.secretContact, required this.removeType});
}

class SecretContactTapEvent extends SecretEvent {
  final dynamic secretContact;
  SecretContactTapEvent({required this.secretContact});
}

class SecretServiceTapEvent extends SecretEvent {
  final ServiceEntity serviceEntity;
  SecretServiceTapEvent({required this.serviceEntity});
}

class SecretHomeTapEvent extends SecretEvent {
  final SecretTapType secretTapType;
  final bool isSecret;
  SecretHomeTapEvent({required this.secretTapType, this.isSecret = false});
}
