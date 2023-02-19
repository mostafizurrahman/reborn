

import 'package:reborn/feature/data_model/base/base_event.dart';
import 'package:reborn/feature/domain/firebase/entities/reborn_name_data.dart';
import 'package:reborn/feature/domain/firebase/entities/search_data.dart';

class RebornFitlerEvent extends CCBaseEvent {

}


class FilterGridRebornEvent extends RebornFitlerEvent {
  final String girdFilterID;
  FilterGridRebornEvent({required this.girdFilterID});
}

class RebornClearFilterEvent extends RebornFitlerEvent {
  RebornClearFilterEvent();
}

class FilterRebornEvent extends RebornFitlerEvent {
  final LocalSearchData searchData;
  FilterRebornEvent({required this.searchData});
}