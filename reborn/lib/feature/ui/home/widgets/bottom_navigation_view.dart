import 'package:flutter/cupertino.dart';
import 'package:reborn/feature/data_model/static_data.dart';
import 'package:reborn/feature/ui/home/home_tab_widget.dart';
import 'package:rxdart/rxdart.dart';

class BottomNavigationView extends StatelessWidget {
  final BehaviorSubject<List<TabBarData>> tabBarBehaviour;
  const BottomNavigationView({
    Key? key,
    required this.tabBarBehaviour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: _tabBarData,
      builder: _getNavigationBar,
      stream: tabBarBehaviour,
    );
  }


  List<TabBarData> get _tabBarData => StaticData.getTabBarData(_onTabBarItemTap);

  void _onTabBarItemTap(final String tabID) {
    final list = tabBarBehaviour.valueOrNull ?? _tabBarData;
    for (final element in list) {
      element.isSelected = element.tabID == tabID;
    }
    tabBarBehaviour.sink.add(list);
    debugPrint("i am here $tabID");
  }

  Widget _getNavigationBar(
    final BuildContext context,
    AsyncSnapshot<List<TabBarData>> snapshot,
  ) {
    return HomeTabWidget(tabDataList: snapshot.data ?? []);
  }
}
