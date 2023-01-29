

import 'package:reborn/feature/data_model/base/base_state.dart';

class RebornFilterState extends CCBaseState {

}


class RebornGridFilterState extends RebornFilterState {
  final String gridFilterID;
  RebornGridFilterState({required this.gridFilterID});
}

class RebornListFilterState extends RebornFilterState {
  final String listFilterID;
  RebornListFilterState({required this.listFilterID});
}