
import 'package:reborn/feature/home/rx_reborn_name/reborn_name_events.dart';
import 'package:reborn/feature/home/rx_reborn_name/reborn_name_states.dart';
import 'package:reborn/feature/home/rx_recent/recent_events.dart';
import 'package:reborn/feature/home/rx_recent/recent_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_model/contact_service.dart';

class RebornNameBloc extends Bloc<RebornNameEvent, RebornNameState> {
  RebornNameBloc() : super(RebornNameState()) {
    on<SetRebornNameEvent>((event, emit) => emit(SetRebornNameState(name: event.name)));
    on<RebornNameEvent>((event, emit) => emit(RebornNameState()));
  }
}
