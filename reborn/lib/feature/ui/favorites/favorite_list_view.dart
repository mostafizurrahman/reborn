import 'package:flutter/material.dart';
import 'package:reborn/feature/domain/firebase/entities/track_entity.dart';
import 'package:reborn/feature/ui/audio_player/audio_player_screen.dart';
import 'package:reborn/feature/ui/track_list/widgets/track_item_view.dart';
import 'package:reborn/utility/screen_data.dart';

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
        child: TrackItemView(track: track, onTap: _onTapAuthor),
      );
      slivers.add(adapter);
    }
    return slivers;
  }


  void _onTapAuthor(final TrackEntity trackEntity) {
    final route = MaterialPageRoute(builder: (BuildContext ctx){
      return AudioPlayerScreen(track: trackEntity);
    });
    Navigator.of(context).push(route);
  }

}