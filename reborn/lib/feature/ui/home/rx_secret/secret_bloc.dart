import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/feature/ui/home/rx_secret/secret_events.dart';
import 'package:reborn/feature/ui/home/rx_secret/secret_states.dart';

class SecretBloc extends Bloc<SecretEvent, SecretState> {
  SecretBloc() : super(SecretState()) {
    on<SecretInitEvent>((event, emit) => emit(SecretInitState()));
    on<SecretAddEvent>(_onAddSecretContact);
    on<SecretRemoveEvent>(_onRemoveSecretContact);
    // on<SecretContactTapEvent>(
    //   (event, emit) => emit(
    //     SecretContactTapState(secretContact: event.secretContact),
    //   ),
    // );
    on<SecretHomeTapEvent>(
      (event, emit) {
        emit(SecretHomeTapState(secretTapType: event.secretTapType, isSecret: event.isSecret));
      },
    );
  }

  Future<void> _onAddSecretContact(
      final SecretAddEvent event, final Emitter<SecretState> emit) async {
    // await sqlDatabase.saveContact(contact: event.secretContact, isSecret: true);
    // emit(
    //   SecretAddState(
    //     secretList: sqlDatabase.secretList,
    //     secretContact: event.secretContact,
    //   ),
    // );
  }

  Future<void> _onRemoveSecretContact(
      final SecretRemoveEvent event, final Emitter<SecretState> emit) async {
    // await sqlDatabase.removeSecret(contact: event.secretContact, removeType: event.removeType);
    // emit(
    //   SecretRemoveState(
    //     secretList: sqlDatabase.secretList,
    //     secretContact: event.secretContact,
    //     removeType: event.removeType,
    //   ),
    // );
  }
}
