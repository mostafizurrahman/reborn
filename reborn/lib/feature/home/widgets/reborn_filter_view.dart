import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/feature/home/rx_reborn_name/reborn_name_bloc.dart';
import 'package:reborn/feature/home/rx_reborn_name/reborn_name_states.dart';
import 'package:reborn/feature/widget/ink_widget.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/image_ext.dart';
import 'package:reborn/utility/screen_data.dart';
import 'package:reborn/utility/user_info.dart';

class RebornFilterView extends StatefulWidget {
  const RebornFilterView({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return RebornHomeFilterState();
  }
}

class RebornHomeFilterState extends State<RebornFilterView> {
  late final List<RebornFilterData> filterList;
  @override
  void initState() {
    super.initState();
    filterList = RebornFilterData.generateGridData();
  }

  @override
  Widget build(BuildContext context) {
    final filterBloc = BlocProvider.of<RebornFilterBloc>(context);
    final height = screenData.height * 0.6;
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: screenData.width,
        height: height,
        child: Column(
          children: [
            SizedBox(
              height: height * 0.15,
              width: screenData.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: RIButton(
                        onTap: () => Scaffold.of(context).openDrawer(),
                        iconData: Icons.menu_rounded,
                        iconColor: CCAppTheme.pinkDarkColor,
                        dimension: 45,
                        radius: 45 / 2),
                  ),
                ],
              ),
            ),
            Image(
                image: ImageExt.getImageAsset("reborn_circle.png"),
                width: screenData.width * 0.225),
            const SizedBox(height: 24),
            Text("Hi ${userInfo.displayName}! Good Day!", style: CCAppTheme.txtHL1),
            const SizedBox(height: 12),
            BlocBuilder(
              builder: _onBuildGridFilter,
              bloc: filterBloc,
            ),
            Text("How are you feeling?", style: CCAppTheme.txtHL2),
            RIButton(
                onTap: () {
                  final bloc = BlocProvider.of<RebornFilterBloc>(context);
                  //show dialog for set feelings...
                },
                iconData: Icons.stream,
                radius: 30),
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
            padding: _getPadding(filterList.length, _index),
            child: Container(
              decoration: CCAppTheme.shadowNoBorder,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: Material(
                  child: Ink(
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

  EdgeInsets _getPadding(final int listLen, final int listIndex) {
    if (listIndex == 0) {
      return const EdgeInsets.only(left: 24, right: 8, top: 8, bottom: 8);
    }
    if (listIndex == listLen - 1) {
      return const EdgeInsets.only(right: 24, top: 8, bottom: 8);
    }
    return const EdgeInsets.all(8);
  }
}
