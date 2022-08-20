
import 'package:reborn/feature/contact_list/rx_contact_list/contact_list_events.dart';
import 'package:reborn/feature/contact_list/rx_contact_list/contact_list_states.dart';
import 'package:reborn/utility/app_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_model/contact_service.dart';

class ContactListBloc extends Bloc<ContactListEvent, ContactListState> {
  ContactListBloc({required final SecretTapType tapType}) : super(ContactListInitState(tapType: tapType)) {
    on<ContactListTapEvent>((event, emit) => emit(ContactListTapState(contact: event.contact)));
    on<ContactListSwipeEvent>(_onUpdateRecentContact);
    on<ContactListDeleteEvent>(_onDeleteContact);
  }

  Future<void> _onUpdateRecentContact(
      final ContactListSwipeEvent event, final Emitter<ContactListState> emit) async {
    emit(ContactListState());
    // await contactService.updateRecent(
    //     contact: event.contact, id: event.recentID);
    emit(ContactListSwipeState(contact: event.contact));
  }

  Future<void> _onDeleteContact(
      final ContactListDeleteEvent event, final Emitter<ContactListState> emit) async {
    emit(ContactListState());
    // await contactService.updateRecent(
    //     contact: event.contact, id: event.recentID);
    emit(ContactListDeleteState(contact: event.contact));
  }
}
