
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/feature/data_model/static_data.dart';
import 'package:reborn/feature/home/rx_reborn_name/reborn_name_bloc.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/screen_data.dart';

class SubFilterView extends StatelessWidget {
  const SubFilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<RebornFilterBloc>(context);
    final list = StaticData.subfilterList;
    final List<Widget> widgets = [];
    for (var data in list) {
      widgets.add(_getFilterItem(data));
      widgets.add(const SliverToBoxAdapter(child: SizedBox(width: 12)));
    }
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: SizedBox(
        height: 40,
        width: screenData.width - 48,
        child: CustomScrollView(
          scrollBehavior: HorizontalScrollBehavior(),
          scrollDirection: Axis.horizontal,
          slivers: widgets,
          shrinkWrap: false,
        ),
      ),
    );
  }

  SliverToBoxAdapter _getFilterItem(final SubFilterData data) {
    final widget  = ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(right: 0),
        child: Material(
          child: Ink(
            height: 40,
            width: 130,
            child: InkWell(
              onTap: (){
                debugPrint("Ready for data");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(data.iconName, color: CCAppTheme.pinkLightColor),
                  const SizedBox(width: 8),
                  Text(data.displayName, style: CCAppTheme.txt2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    return SliverToBoxAdapter(child: widget);
  }
}
