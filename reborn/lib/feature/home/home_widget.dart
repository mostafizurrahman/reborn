import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:reborn/feature/data_model/entity/service_entity.dart';
import 'package:reborn/feature/home/home_recent_widget.dart';
import 'package:reborn/feature/home/home_secret_widget.dart';
import 'package:reborn/feature/home/home_tab_widget.dart';
import 'package:reborn/feature/home/rx_recent/recent_bloc.dart';
import 'package:reborn/feature/home/rx_recent/recent_states.dart';
import 'package:reborn/feature/home/rx_secret/secret_states.dart';
import 'package:reborn/feature/home/widgets/sub_filter_view.dart';
import 'package:reborn/feature/menu/menu_widget.dart';
import 'package:reborn/feature/widget/widget_properties.dart';
import 'package:reborn/routing/app_route.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/screen_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:ui' as ui;

import '../../rx_export.dart';
import '../data/network/firebase_api.dart';
import '../data_model/static_data.dart';
import '../widget/base_widget/theme_state.dart';
import 'rx_reborn_name/reborn_name_bloc.dart';
import 'rx_reborn_name/reborn_name_states.dart';
import 'widgets/reborn_filter_view.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends ThemeState<HomeWidget> {
  late final BehaviorSubject<List<TabBarData>> _navigationTabBehaviour;
  // final RecentBloc recentBloc = RecentBloc();
  // final SecretBloc secretBloc = SecretBloc();
  final RebornFilterBloc _rebornNameBloc = RebornFilterBloc();

  @override
  void initState() {
    super.initState();
    final _tabBarData = StaticData.getTabBarData(_onTabBarItemTap);
    _navigationTabBehaviour = BehaviorSubject<List<TabBarData>>.seeded(_tabBarData);
    _read();
  }

  Future<void> _read() async {
    final list = await FirebaseAuthorApi().getList();
    print(list);
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
        BlocProvider<RebornFilterBloc>.value(value: _rebornNameBloc),
      ],
      child: BaseScaffoldState(

      ),
    );
  }

  Widget _getBody() {
    return Scaffold(
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
          color: CCAppTheme.pinkDarkerColor,
          child: Center(
            child: Container(

              decoration: CCAppTheme.shadowDec.copyWith(color: CCAppTheme.pinkDarkColor),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 200, horizontal: 48),
                child: Container(
                  decoration: CCAppTheme.shadowDec.copyWith(color: CCAppTheme.pinkMediumColor),

                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 150, horizontal: 48),
                    child: Container(
                      decoration: CCAppTheme.shadowDec.copyWith(color: CCAppTheme.pinkLightColor),
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _onBuildFilterBloc(final BuildContext context, final RebornFilterState state) {
    return const RebornFilterView();
  }

  Widget _onBuildSubfilterBloc(final BuildContext context, final RebornFilterState state) {
    return const SubFilterView();
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

  List<Widget> _getContentList() {
    final categories = StaticData.categoryList;
    List<Widget> list = [];

    final rand = Random();
    for (int i = 0; i < categories.length; i++) {
      final _category = categories[i];
      final author = _category.rebornMeditationList.first.authorList.first;
      final _widget = SizedBox(
        width: screenData.width,
        height: 330,
        child: ListView.builder(
            itemBuilder: (context, index) {
              final data = _category.rebornMeditationList[index];
              return Padding(
                padding: EdgeInsets.only(right: 24, bottom: 6, top: 6, left: index == 0 ? 24 : 0),
                child: Container(

                width: screenData.width * 0.8 - 12,
                height: screenData.width * 0.6 - 15,
                decoration: CCAppTheme.shadowNoBorder,
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    child: Material(

                      child: Ink(
                        decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(_category.rebornMeditationList.first.meditationList.first.meditationCoverImage),
                            fit: BoxFit.cover
                        ), ),
                        child: BackdropFilter(
                          filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: InkWell(

                            onTap: (){
                              debugPrint("done");
                            },
                            hoverColor: Colors.blueAccent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                _category.rebornMeditationList.first.isPremiumMeditation
                                    ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [Icon(Icons.lock_outline_rounded)],
                                )
                                    : const SizedBox(),
                                Expanded(child: SizedBox()),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.favorite, color: CCAppTheme.periwinkleLightColor),
                                    const SizedBox(width: 12),
                                    Text(data.meditationList.first.meditationType, style: CCAppTheme.txt2.copyWith(color: Colors.white),)
                                  ],
                                ),
                                Text(_category.categoryTitle, style: CCAppTheme.txtHL1.copyWith(color: Colors.white)),
                                SizedBox(height: screenData.width * 0.3),
                                Container(
                                  width: screenData.width * 0.8,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                                          child: CachedNetworkImage(
                                              imageUrl: author.authorImage,
                                              width: 44,
                                              height: 44,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(author.authorName,
                                              style: CCAppTheme.txtHL1
                                                  .copyWith(overflow: TextOverflow.fade)),
                                          SizedBox(height: 8),
                                          Text(author.authorDescription.substring(0, 30)+"...", style: CCAppTheme.txtHL3.copyWith(color: CCAppTheme.pinkDarkColor, overflow: TextOverflow.clip),),
                                        ],
                                      ),
                                    ],
                                  ),
                                  color: Colors.grey.shade300,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: _category.rebornMeditationList.length,
            scrollDirection: Axis.horizontal),
      );
      list.add(SizedBox(height: 24));
      list.add(Padding(
        padding: EdgeInsets.only(left: 24, top: 8, bottom: 6),
        child: Text(_category.categoryTitle, style: CCAppTheme.txtHL1),
      ));
      list.add(_widget);
    }

    return list;
  }

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
