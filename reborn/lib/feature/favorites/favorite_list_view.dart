import 'package:flutter/material.dart';
import 'package:reborn/feature/track_list/widgets/list_cover_view.dart';
import 'package:reborn/feature/track_list/widgets/track_item_view.dart';
import 'package:reborn/utility/screen_data.dart';
import '../../rx_export.dart';
import '../domain/entities.dart';
import '../widget/view_provider.dart';

class TrackListView extends StatefulWidget {
  final List<TrackEntity> tracks;
  const TrackListView({Key? key, required this.tracks}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TrackListViewState();
  }
}

class _TrackListViewState extends State<TrackListView> {



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenData.width,
      height: screenData.height,
      child: CustomScrollView(
        slivers: [
          // SliverToBoxAdapter(
          //   child: ListCoverView(summary: widget.summary),
          // ),
          ..._getSlivers(),
        ],
      ),
    );
  }

  List<SliverToBoxAdapter> _getSlivers() {
    final List<SliverToBoxAdapter> slivers = [];
    for(final track in widget.tracks) {
      final SliverToBoxAdapter adapter = SliverToBoxAdapter(
        child: TrackItemView(track: track),
      );
      slivers.add(adapter);
    }
    return slivers;
  }


}