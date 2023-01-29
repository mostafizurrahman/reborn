import 'package:reborn/feature/data_model/base/base_state.dart';
import 'package:reborn/feature/data_model/entity/service_entity.dart';
import 'package:reborn/utility/app_enum.dart';

class SecretState extends CCBaseState {

}

class SecretInitState extends SecretState {

}

class SecretAddState extends SecretState {
  final List<dynamic> secretList;
  final dynamic secretdynamic;
  SecretAddState({required this.secretList, required this.secretdynamic});
}

class SecretRemoveState extends SecretState {
  final dynamic secretdynamic;
  final SecretRemoveType removeType;
  final List<dynamic> secretList;
  SecretRemoveState({required this.secretList, required this.secretdynamic, required this.removeType});
}

class SecretdynamicTapState extends SecretState {
  final dynamic secretdynamic;
  SecretdynamicTapState({required this.secretdynamic});
}

class SecretHomeTapState extends SecretState {
  final SecretTapType secretTapType;
  final bool isSecret;
  SecretHomeTapState({required this.secretTapType, required this.isSecret});
}
