import 'package:flutter/material.dart';
import 'package:reborn/feature/domain/firebase/usecase/get_category_track_use_case.dart';
import 'package:reborn/feature/home/widgets/track_cover_view.dart';
import 'package:reborn/feature/home/widgets/track_grid_view.dart';
import 'package:reborn/feature/widget/base_widget/theme_state.dart';
import 'package:reborn/utility/screen_data.dart';

import '../../../utility/app_theme_data.dart';
import '../../domain/entities.dart';
import '../rx_firebase_bloc/firebase_data_states.dart';
import 'category_title_view.dart';

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
  @override
  Widget build(BuildContext context) {
    final double height = screenData.width * 0.65;

    return SizedBox(
      height: height,
      width: screenData.width,
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: CategoryTitleView(
              category: widget.category,
            ),
          ),
          SizedBox(
            height: height - 50,
            child: _getListWidget(),
          )
        ],
      ),
    );
  }

  Widget _getListWidget() {
    final List<TrackEntity> tracks = widget.firebaseState.tracks;
    final List<String> trackIdList = widget.category.tracksIdList;
    final List<FBAuthor> authors = widget.firebaseState.authors;
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
}
