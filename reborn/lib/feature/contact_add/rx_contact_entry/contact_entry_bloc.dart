

import 'package:reborn/rx_export.dart';
import 'package:reborn/utility/app_enum.dart';
import 'package:contacts_service/contacts_service.dart';
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
  final Contact _contact = Contact();

  ContactEntryBloc({required final SecretTapType tapType}) : super(ContactEntryInitState(tapType: tapType)) {
    on<ContactAddFieldEvent>((event, emit) => emit(ContactAddFieldState(fieldID: event.fieldID)));
    // on<ContactFavoriteEvent>(_onUpdateRecentContact);
    // on<ContactListDeleteEvent>(_onDeleteContact);
  }
}