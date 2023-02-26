import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/ui/filtering/rx_filter/reborn_name_bloc.dart';
import 'package:reborn/feature/domain/firebase/entities/reborn_name_data.dart';
import 'package:reborn/feature/ui/home/rx_firebase_bloc/firebase_data_bloc.dart';
import 'package:reborn/feature/ui/home/rx_firebase_bloc/firebase_data_states.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/screen_data.dart';
import 'rx_filter/reborn_name_events.dart';
import 'rx_filter/reborn_name_states.dart';

class FilterGridItemView extends StatelessWidget {
  final RebornFilterData filterData;
  final int dataCount;
  final int dataIndex;

  const FilterGridItemView({
    Key? key,
    required this.filterData,
    required this.dataCount,
    required this.dataIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<RebornFilterBloc>(context);
    final dataBloc = BlocProvider.of<FirebaseDataBloc>(context);

    return Padding(
      padding: screenData.getHorizontalPadding(
        dataCount,
        dataIndex,
      ),
      child: Container(
        decoration: CCAppTheme.shadowNoBorder,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          child: Material(
            color: Colors.transparent,
            child: _getFilterItemView(filterBloc: bloc, dataBloc: dataBloc),
          ),
        ),
      ),
    );
  }

  Widget _getFilterItemView({
    required final RebornFilterBloc filterBloc,
    required final FirebaseDataBloc dataBloc,
  }) {
    return Ink(
      color: Colors.transparent,
      width: 85,
      height: 60,
      child: InkWell(
        focusColor: CCAppTheme.pinkLightColor,
        splashColor: CCAppTheme.periwinkleDarkColor,
        onTap: () => _onFilterData(filterBloc, dataBloc),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              filterData.iconData ?? Icons.favorite,
              color: CCAppTheme.pinkLightColor,
              size: 24,
            ),
            const SizedBox(height: 12),
            Text(
              filterData.displayName,
              style: CCAppTheme.txtNormal,
            ),
          ],
        ),
      ),
    );
  }

  void _onFilterData(
    final RebornFilterBloc filterBloc,
    final FirebaseDataBloc dataBloc,
  ) {
    final firebaseState = dataBloc.state;
    if (firebaseState is FirebaseDataReadyState) {
      filterData.isSelected = !filterData.isSelected;
      final RebornFilterState filterState = filterBloc.state;
      final FilterRebornEvent rebornEvent;
      // final useCase = GetSummaryUseCase(
      //     tracks: firebaseState.tracks, authors: firebaseState.authors);
      // useCase(category).then(onSummaryCreated);

      if (filterState is FilterRebornState) {
        final list = List<RebornFilterData>.from(filterState.gridFilter);
        if (filterData.isSelected) {
          list.add(filterData);
        } else {
          list.remove(filterData);
        }
        final searchData = LocalSearchData(
          categories: firebaseState.categories,
          tracks: firebaseState.tracks,
          gridData: list,
        );
        rebornEvent = FilterRebornEvent(searchData: searchData);
      } else {
        final searchData = LocalSearchData(
          categories: firebaseState.categories,
          tracks: firebaseState.tracks,
          gridData: [filterData],
        );
        rebornEvent = FilterRebornEvent(searchData: searchData);
      }
      filterBloc.add(rebornEvent);
    }
  }
}
