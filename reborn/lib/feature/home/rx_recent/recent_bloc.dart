
import 'package:reborn/feature/home/rx_recent/recent_events.dart';
import 'package:reborn/feature/home/rx_recent/recent_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_model/contact_service.dart';

class RecentBloc extends Bloc<RecentEvent, RecentState> {
  RecentBloc() : super(RecentState()) {
    on<RecentShimmerEvent>((event, emit) => emit(RecentShimmerState()));
    on<RecentUpdateEvent>(_onUpdateRecentContact);
    on<RecentTapEvent>((event, emit) => emit(TapRecentState(recentService: event.service)));
  }

  Future<void> _onUpdateRecentContact(
      final RecentUpdateEvent event, final Emitter<RecentState> emit) async {
    emit(RecentShimmerState());
    // await contactService.updateRecent(
    //     contact: event.contact, id: event.recentID);
    emit(UpdateRecentState());
  }
}
