import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/feature/domain/firebase/usecase/get_category_track_use_case.dart';
import 'package:reborn/feature/domain/firebase/usecase/get_summary_use_case.dart';
import 'package:reborn/feature/home/widgets/cubit/cubit_states.dart';
import 'package:reborn/feature/home/widgets/track_cover_view.dart';
import 'package:reborn/feature/home/widgets/track_grid_view.dart';
import 'package:reborn/feature/track_list/track_list_page.dart';
import 'package:reborn/feature/widget/base_widget/theme_state.dart';
import 'package:reborn/utility/screen_data.dart';

import '../../../utility/app_theme_data.dart';
import '../../domain/entities.dart';
import '../rx_firebase_bloc/firebase_data_states.dart';
import 'category_title_view.dart';
import 'cubit/summary_cubit.dart';
import 'track_category_view.dart';

class RebornCategoryView extends StatefulWidget {
  final FirebaseDataReadyState firebaseState;
  final RebornCategory category;
  const RebornCategoryView({
    Key? key,
    required this.firebaseState,
    required this.category,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RebornCategoryState();
  }
}

class _RebornCategoryState extends State<RebornCategoryView> {

  final cubit = SummaryCubit();

  @override
  Widget build(BuildContext context) {
    final double height = screenData.width * 0.8;

    return SizedBox(
      height: height,
      width: screenData.width,
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: CategoryTitleView(
              category: widget.category,
              firebaseState: widget.firebaseState,
              onSummaryCreated: _onSummaryCreated,
            ),
          ),
          SizedBox(
            height: height - 50,
            child: _getListWidget(height - 50),
          ),
        ],
      ),
    );
  }

  void _onSummaryCreated(final CategorySummary summary) {
    Navigator.of(context).pushNamed(TrackListPage.path, arguments:  {"summary" : summary});
  }

  Widget _getSummaryWidget(final BuildContext ctx, final CubitBaseState state) {
    if (state is CubitSummaryCategoryState) {
      final height = screenData.width * 0.65 - 50;
      return TrackCategoryView(
        category: widget.category,
        height: height,
        summary: state.summary,
      );
    }
    return const CircularProgressIndicator();
  }

  Widget _getListWidget(final double height) {
    final List<TrackEntity> tracks = widget.firebaseState.tracks;
    final List<String> trackIdList = widget.category.tracksIdList;
    final List<RebornAuthor> authors = widget.firebaseState.authors;
    if (widget.category.categoryType == "home/tracks") {
      cubit.emitCategorySummary(tracks, authors, widget.category);
      return BlocBuilder<SummaryCubit, CubitBaseState>(
        builder: _getSummaryWidget,
        bloc: cubit,
      );
    }
    final useCase = GetCategoryTrackUseCase(trackList: tracks, authorList: authors);
    final List<TrackEntity> trackList = useCase.getFilterList(trackIdList);
    return ListView.builder(
      itemBuilder: (final listContext, final _index) {
        final track = trackList[_index];
        final isGrid = widget.category.tracksType == CategoryTrackType.gridTrack;
        final trackWidget = isGrid ? TrackGridView(track: track) : TrackCoverView(track: track);
        return Padding(
          padding: screenData.getHorizontalPadding(trackList.length, _index),
          child: Container(
            decoration: CCAppTheme.shadowNoBorder,
            child: trackWidget,
          ),
        );
      },
      itemCount: trackList.length,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
    );
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }
}
