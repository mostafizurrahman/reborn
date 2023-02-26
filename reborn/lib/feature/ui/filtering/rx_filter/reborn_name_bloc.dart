import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:reborn/feature/domain/entities.dart';

import 'reborn_name_events.dart';
import 'reborn_name_states.dart';

class RebornFilterBloc extends Bloc<RebornFitlerEvent, RebornFilterState> {
  final Set<String> keys = {};
  RebornFilterBloc() : super(RebornFilterState()) {
    on<FilterGridRebornEvent>((event, emit) =>
        emit(RebornGridFilterState(gridFilterID: event.girdFilterID)));
    on<RebornClearFilterEvent>((event, emit) => emit(RebornClearFilterState()));
    on<RebornFitlerEvent>((event, emit) => emit(RebornFilterState()));
    on<FilterRebornEvent>(_onFilterCategory);
  }

  Future<void> _onFilterCategory(final FilterRebornEvent event,
      final Emitter<RebornFilterState> emit) async {

    emit(FilterLoadingState());
    await Future.delayed(Duration(seconds: 1));

    if (event.searchData.listData.isEmpty &&
        event.searchData.gridData.isEmpty) {
      emit(RebornClearFilterState());
    } else {
      final categories = await _getCategories(searchData: event.searchData);
      final state =  FilterRebornState(categories: categories);
      emit(state);
    }
    debugPrint(state.toString());
  }

  Future<List<RebornCategory>> _getCategories(
      {required final LocalSearchData searchData}) async {
    keys.clear();
    final List<String> ids = searchData.gridData.map((e) => e.displayName.toLowerCase()).toList();
    keys.addAll(ids.toSet());
    List<RebornCategory> categories = [];
    if (searchData.gridData.isNotEmpty) {
      for(final category in searchData.categories) {
        final List<String> trackList = [];
        for(final String trackID in category.tracksIdList) {
          if(searchData.tracks.firstWhereOrNull(_hasItem) != null) {
            trackList.add(trackID);
          }
        }
        if (trackList.isNotEmpty) {
          assert(trackList.length == category.tracksIdList.length, "Your search is working");
          categories.add(category.copyWith(tracks: trackList));
        }
      }
    }
    if (searchData.listData.isNotEmpty) {}
    return categories;
  }

  bool _hasItem(final TrackEntity track) {
    final Set<String> genre = track.generList.toSet();
    return genre.intersection(keys).isNotEmpty;
  }
}
