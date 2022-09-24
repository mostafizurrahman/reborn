import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reborn/feature/base_widget/base_scaffold_state.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/track_list/widgets/track_item_view.dart';
import 'package:reborn/feature/widget/base_widget/theme_state.dart';
import 'package:reborn/feature/widget/view_provider.dart';
import 'package:reborn/utility/screen_data.dart';

import 'widgets/list_cover_view.dart';

class TrackListPage extends StatefulWidget {
  final CategorySummary summary;
  const TrackListPage({Key? key, required this.summary}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TrackListState();
  }

  static const path = "home/tracks";
  static CategorySummary getSummary(final Map args) {
    return args["summary"] as CategorySummary;
  }
}

class _TrackListState extends State<TrackListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldState(
      body: Container(
        width: screenData.width,
        height: screenData.height,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ListCoverView(summary: widget.summary),
            ),
            ..._getSlivers(),
          ],
        ),
      ),
      floatLocation: FloatingActionButtonLocation.startTop,
      floating: ViewProvider.backButton(context),
    );
  }

  List<SliverToBoxAdapter> _getSlivers() {
    final List<SliverToBoxAdapter> slivers = [];
    for(final track in widget.summary.tracks) {
      final SliverToBoxAdapter adapter = SliverToBoxAdapter(
        child: TrackItemView(track: track),
      );
      slivers.add(adapter);
    }
    return slivers;
  }

}
