import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/feature/home/rx_reborn_name/reborn_name_bloc.dart';
import 'package:reborn/feature/home/rx_reborn_name/reborn_name_states.dart';
import 'package:reborn/feature/ui/widget/base_widget/theme_state.dart';
import 'package:reborn/feature/ui/widget/ink_widget.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/image_ext.dart';
import 'package:reborn/utility/screen_data.dart';
import 'package:reborn/utility/user_info.dart';

import 'sub_filter_view.dart';

class RebornFilterView extends StatefulWidget {
  const RebornFilterView({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return RebornHomeFilterState();
  }
}

class RebornHomeFilterState extends ThemeState<RebornFilterView> {
  late final List<RebornFilterData> filterList;
  @override
  void initState() {
    super.initState();
    filterList = RebornFilterData.generateGridData();
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: RIButton(
                        onTap: () => Scaffold.of(context).openDrawer(),
                        iconData: Icons.menu_rounded,
                        iconColor: CCAppTheme.pinkDarkColor,
                        dimension: 40,
                        radius: 20),
                  ),
                  const Spacer(),
                  Text("Reborn", style: headStyle1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Image(
                      image: ImageExt.getImageAsset("reborn_circle.png"),
                      width: 40,),
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

  Widget _onBuildGridFilter(final BuildContext _context, final RebornFilterState filterState) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        itemBuilder: (final listContext, final _index) {
          return Padding(
            padding: screenData.getHorizontalPadding(filterList.length, _index),
            child: Container(
              decoration: CCAppTheme.shadowNoBorder,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: Material(
                  color: Colors.transparent,
                  child: Ink(
                    color: Colors.transparent,
                    width: 80,
                    height: 60,
                    child: InkWell(
                      focusColor: CCAppTheme.pinkLightColor,
                      splashColor: CCAppTheme.periwinkleDarkColor,
                      onTap: () {
                        debugPrint("filter tap on ${filterList[_index]}");
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(filterList[_index].iconData ?? Icons.favorite,
                              color: CCAppTheme.pinkLightColor),
                          const SizedBox(height: 12),
                          Text(filterList[_index].displayName, style: CCAppTheme.txt1),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: filterList.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
      ),
    );
  }


}
