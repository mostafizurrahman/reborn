import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:reborn/feature/ui/filtering/filter_grid_item_view.dart';
import 'package:reborn/feature/ui/filtering/rx_filter/reborn_name_bloc.dart';
import 'package:reborn/feature/domain/firebase/entities/reborn_name_data.dart';
import 'package:reborn/feature/ui/filtering/rx_filter/reborn_name_events.dart';

import 'package:reborn/feature/ui/widget/base_widget/theme_state.dart';
import 'package:reborn/feature/ui/widget/ink_widget.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/image_ext.dart';
import 'package:reborn/utility/screen_data.dart';
import 'package:rxdart/rxdart.dart';
import '../home/widgets/sub_filter_view.dart';
import 'rx_filter/reborn_name_states.dart';

class RebornFilterView extends StatefulWidget {
  final List<RebornFilterData> filterList;
  const RebornFilterView({Key? key, required this.filterList}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return RebornHomeFilterState();
  }
}


class RebornHomeFilterState extends ThemeState<RebornFilterView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final filterBloc = BlocProvider.of<RebornFilterBloc>(context);

    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: screenData.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 65,
              width: screenData.width,
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Image(
                        image:
                            ImageExt.getImageAsset("reborn_banner_small.png"),
                        height: 50,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: RIButton(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      iconData: Icons.menu_rounded,
                      iconColor: CCAppTheme.pinkDarkColor,
                      dimension: 40,
                      radius: 20,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 2, color: Colors.black54),
            const SizedBox(height: 8),
            BlocBuilder(
              builder: _onBuildGridFilter,
              bloc: filterBloc,
            ),
            const SizedBox(height: 12),
            const SubFilterView(),
          ],
        ),
      ),
    );
  }

  Widget _onBuildGridFilter(
    final BuildContext context,
    final RebornFilterState filterState,
  ) {
    final itemCount = widget.filterList.length;
    return SizedBox(
      height: 90,
      child: ListView.builder(
        itemBuilder: (final listContext, final index) {
          final data = widget.filterList[index];
          return FilterGridItemView(
            filterData: data,
            dataCount: itemCount,
            dataIndex: index,
          );
        },
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
      ),
    );
  }
}
