


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reborn/feature/base_widget/base_scaffold_state.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/widget/base_widget/theme_state.dart';
import 'package:reborn/feature/widget/view_provider.dart';
import 'package:reborn/utility/screen_data.dart';

import 'widgets/list_cover_view.dart';

class TrackListPage extends StatefulWidget {

  final RebornCategory category;
  final CategorySummary summary;
  const TrackListPage({Key? key, required this.category,required this.summary}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TrackListState();
  }

  static const path = "home/tracks";

  static CategorySummary getSummary(final Map args) {
    return args["summary"] as CategorySummary;
  }

  static RebornCategory getCategory(final Map args) {
    return args["category"] as RebornCategory;
  }

}

class _TrackListState extends State<TrackListPage> {

  @override
  void initState() {
    super.initState();

    widget.summary.iconData = widget.category.logoData.toInt();
    widget.summary.coverImage = widget.category.categoryCover;
    widget.summary.title = widget.category.title;
  }

  @override
  Widget build(BuildContext context) {

    return BaseScaffoldState(
      body: Container(
        width: screenData.width,
        height: screenData.height,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: ListCoverView(summary: widget.summary),),
          ],
        ),
      ),
      floatLocation: FloatingActionButtonLocation.startTop,
      floating: ViewProvider.backButton(context),
    );
  }
}