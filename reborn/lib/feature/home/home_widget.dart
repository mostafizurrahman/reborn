import 'package:reborn/feature/data_model/entity/service_entity.dart';
import 'package:reborn/feature/home/home_recent_widget.dart';
import 'package:reborn/feature/home/home_secret_widget.dart';
import 'package:reborn/feature/home/home_tab_widget.dart';
import 'package:reborn/feature/home/rx_recent/recent_bloc.dart';
import 'package:reborn/feature/home/rx_recent/recent_states.dart';
import 'package:reborn/feature/home/rx_secret/secret_states.dart';
import 'package:reborn/feature/menu/menu_widget.dart';
import 'package:reborn/feature/widget/widget_properties.dart';
import 'package:reborn/routing/app_route.dart';
import 'package:reborn/utility/screen_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data_model/static_data.dart';
import '../menu/app_bar_widget.dart';
import '../widget/base_widget/theme_state.dart';
import '../widget/service_widget.dart';
import 'home_grid_widget.dart';
import 'rx_reborn_name/reborn_name_bloc.dart';
import 'rx_reborn_name/reborn_name_states.dart';
import 'rx_secret/secret_bloc.dart';
import 'widgets/home_reborn_name_view.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeState();
  }
}

class _HomeState extends ThemeState<HomeWidget> {
  late final BehaviorSubject<List<TabBarData>> _navigationTabBehaviour;
  // final RecentBloc recentBloc = RecentBloc();
  // final SecretBloc secretBloc = SecretBloc();
  final RebornNameBloc _rebornNameBloc = RebornNameBloc();

  @override
  void initState() {
    super.initState();
    final _tabBarData = StaticData.getTabBarData(_onTabBarItemTap);
    _navigationTabBehaviour = BehaviorSubject<List<TabBarData>>.seeded(_tabBarData);

  }

  void _onSecretStateChanged(final SecretState state) {
    if (state is SecretHomeTapState) {
      final bool isAdd = StaticData.parentTypes.contains(state.secretTapType);
      final Map args = {ArgsKey.secretType: state.secretTapType, "secret": state.isSecret};
      args["title"] = isAdd ? "Add Contact" : "Contact List";
      isAdd
          ? Navigator.pushNamed(context, AppRoutes.entry, arguments: args)
          : Navigator.pushNamed(context, AppRoutes.list, arguments: args);
    }
  }

  @override
  Widget build(BuildContext context) {
    screenData.setScreenData(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<RebornNameBloc>.value(value: _rebornNameBloc),
      ],
      child: Scaffold(

        floatingActionButton: StreamBuilder(
          builder: _getNavigationBar,
          stream: _navigationTabBehaviour,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        drawer: const MenuWidget(),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.grey,
            image: DecorationImage(
              image: AssetImage("lib/assets/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            width: screenData.width,
            height: screenData.height,
            color: Colors.grey.shade300.withAlpha(100),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    BlocBuilder(builder: _onBuildNameBloc, bloc: _rebornNameBloc),
                    // BlocBuilder(builder: _getRecentBlocWidget, bloc: recentBloc),
                    // BlocBuilder(builder: _getSecretContactWidget, bloc: secretBloc),
                    // BlocBuilder(builder: _getPrivateContactWidget, bloc: secretBloc),
                    // HomeGridWidget(onGridTap: _onUtilityTap),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _onBuildNameBloc(final BuildContext context, final RebornNameState state) {
    return const HomeRebornNameView();
  }

  void _onUtilityTap(final String routPath) {}

  // Widget _getSecretContactWidget(final BuildContext context, final SecretState state) {
  //   // return HomeSecretWidget(secretBloc: secretBloc);
  // }
  //
  // Widget _getPrivateContactWidget(final BuildContext context, final SecretState state) {
  //   // return HomePrivateWidget(secretBloc: secretBloc);
  // }
  //
  // Widget _getRecentBlocWidget(final BuildContext context, final RecentState state) {
  //   // return HomeRecentWidget(recentBloc: recentBloc);
  // }

  void _onTabBarItemTap(final String tabID) {
    final _list = _navigationTabBehaviour.value;
    for (final element in _list) {
      element.isSelected = element.tabID == tabID;
    }
    _navigationTabBehaviour.sink.add(_list);
    debugPrint("i am here $tabID");
  }

  Widget _getNavigationBar(final BuildContext context, AsyncSnapshot<List<TabBarData>> snapshot) {
    return HomeTabWidget(tabDataList: snapshot.data ?? []);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // recentBloc.close();
    // secretBloc.close();
  }
}
