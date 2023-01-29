

import 'package:reborn/feature/ui/contact_add/rx_contact_entry/contact_entry_events.dart';
import 'package:reborn/feature/ui/contact_add/rx_contact_entry/contact_entry_states.dart';
import 'package:reborn/rx_export.dart';
import 'package:reborn/utility/app_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _ContactNameData {
  String? givenName;
  String? displayName;
  String? middleName;
  String? familyName;
  String? prefix;
  String? suffix;
}

class ContactEntryBloc extends Bloc<ContactEntryEvent, ContactEntryState> {

  final _contactData = _ContactNameData();
  late final dynamic _contact ;

  ContactEntryBloc({required final SecretTapType tapType}) : super(ContactEntryInitState(tapType: tapType)) {
    on<ContactAddFieldEvent>((event, emit) => emit(ContactAddFieldState(fieldID: event.fieldID)));
    // on<ContactFavoriteEvent>(_onUpdateRecentContact);
    // on<ContactListDeleteEvent>(_onDeleteContact);
  }
}