

import 'package:reborn/feature/data_model/base/base_event.dart';

class RebornFitlerEvent extends CCBaseEvent {

}


class FilterGridRebornEvent extends RebornFitlerEvent {
  final String girdFilterID;
  FilterGridRebornEvent({required this.girdFilterID});
}

class FilterListRebornEvent extends RebornFitlerEvent {
  final String listFilterID;
  FilterListRebornEvent({required this.listFilterID});
}