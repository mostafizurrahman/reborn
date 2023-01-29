import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/feature/ui/home/rx_reborn_name/reborn_name_events.dart';
import 'package:reborn/feature/ui/home/rx_reborn_name/reborn_name_states.dart';

class RebornFilterData {
  final String filterID;
  final String displayName;
  final int displayOrder;
  final IconData? iconData;
  final String? iconPath;
  RebornFilterData(
      {required this.filterID,
      required this.displayName,
      required this.displayOrder,
      this.iconData,
      this.iconPath});

  static List<RebornFilterData> generateGridData() {
    List<RebornFilterData> data = [];
    Map<String, IconData> _titles = {
      "Wellness": Icons.stream,
      "Meditation": Icons.center_focus_strong_outlined,
      "Sounds": Icons.speaker_outlined,
      "Story": Icons.description_outlined,
      "Coaching": Icons.leak_add_rounded,
      "Breathwork": Icons.healing,
      "Music": Icons.music_note_outlined,
      "ASMR": Icons.star,
      "Emotions": Icons.ac_unit_sharp,
      "Therapy": CupertinoIcons.brightness,
      "Programs": CupertinoIcons.square_stack_3d_down_right,
      "Hypnosis": CupertinoIcons.bed_double,
      "Stories": CupertinoIcons.book
    };
    int i = 0;
    _titles.forEach((key, value) {
      data.add(RebornFilterData(
          displayOrder: i++,
          filterID: "${key.toLowerCase()}_$i",
          displayName: key,
          iconData: value));
    });
    return data;
  }
}

class RebornFilterBloc extends Bloc<RebornFitlerEvent, RebornFilterState> {
  RebornFilterBloc() : super(RebornFilterState()) {
    on<FilterGridRebornEvent>(
        (event, emit) => emit(RebornGridFilterState(gridFilterID: event.girdFilterID)));

    on<FilterListRebornEvent>(
        (event, emit) => emit(RebornListFilterState(listFilterID: event.listFilterID)));
    on<RebornFitlerEvent>((event, emit) => emit(RebornFilterState()));
  }
}
