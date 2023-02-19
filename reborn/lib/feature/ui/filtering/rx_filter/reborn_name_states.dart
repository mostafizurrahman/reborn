import 'package:reborn/feature/data_model/base/base_state.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/domain/firebase/entities/reborn_name_data.dart';

class RebornFilterState extends CCBaseState {}

class FilterLoadingState extends RebornFilterState {}

class RebornGridFilterState extends RebornFilterState {
  final String gridFilterID;
  RebornGridFilterState({required this.gridFilterID});
}

class RebornClearFilterState extends RebornFilterState {
  RebornClearFilterState();
}

class FilterRebornState extends RebornFilterState {
  final List<RebornCategory> categories;
  final List<RebornFilterData> gridFilter;
  final List<RebornFilterData> listFilter;

  FilterRebornState({
    required this.categories,
    this.gridFilter = const [],
    this.listFilter = const [],
  });
}
