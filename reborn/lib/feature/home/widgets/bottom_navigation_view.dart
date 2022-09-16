import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import '../../data_model/static_data.dart';
import '../home_tab_widget.dart';

class BottomNavigationView extends StatelessWidget {
  final BehaviorSubject<List<TabBarData>> tabBarBehaviour;
  const BottomNavigationView({
    Key? key,
    required this.tabBarBehaviour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _tabBarData = StaticData.getTabBarData(_onTabBarItemTap);
    return StreamBuilder(
      initialData: _tabBarData,
      builder: _getNavigationBar,
      stream: tabBarBehaviour,
    );
  }

  void _onTabBarItemTap(final String tabID) {
    final _list = tabBarBehaviour.value;
    for (final element in _list) {
      element.isSelected = element.tabID == tabID;
    }
    tabBarBehaviour.sink.add(_list);
    debugPrint("i am here $tabID");
  }

  Widget _getNavigationBar(
    final BuildContext context,
    AsyncSnapshot<List<TabBarData>> snapshot,
  ) {
    return HomeTabWidget(tabDataList: snapshot.data ?? []);
  }
}
