import 'package:flutter/cupertino.dart';
import 'package:reborn/feature/data_model/static_data.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/ui/base_widget/base_scaffold_state.dart';
import 'package:reborn/feature/ui/favorites/home_favorite_view.dart';
import 'package:reborn/feature/ui/filtering/rx_filter/reborn_name_events.dart';
import 'package:reborn/feature/ui/filtering/rx_filter/reborn_name_states.dart';
import 'package:reborn/feature/ui/home/home_tab_widget.dart';
import 'package:reborn/feature/ui/home/rx_firebase_bloc/firebase_data_bloc.dart';
import 'package:reborn/feature/ui/home/rx_firebase_bloc/firebase_data_events.dart';
import 'package:reborn/feature/ui/home/rx_firebase_bloc/firebase_data_states.dart';
import 'package:reborn/feature/ui/home/widgets/home_coach_view.dart';
import 'package:reborn/feature/ui/home/widgets/home_profile_view.dart';
import 'package:reborn/feature/ui/home/widgets/home_sleep_view.dart';
import 'package:reborn/feature/ui/menu/menu_widget.dart';
import 'package:reborn/feature/ui/widget/base_widget/theme_state.dart';
import 'package:reborn/feature/ui/widget/category_list_view.dart';
import 'package:reborn/feature/ui/widget/loader/loading_view.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/screen_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../filtering/rx_filter/reborn_name_bloc.dart';
import 'widgets/bottom_navigation_view.dart';
import 'widgets/reborn_category_view.dart';
import '../filtering/reborn_filter_view.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends ThemeState<HomeWidget> {

  final filterList = RebornFilterData.generateGridData();
  final BehaviorSubject<List<TabBarData>> _tabBehaviour = BehaviorSubject();
  final RebornFilterBloc _rebornNameBloc = RebornFilterBloc();
  final FirebaseDataBloc _firebaseBloc = FirebaseDataBloc();
  final BehaviorSubject<bool> _filterClearBehavior =
      BehaviorSubject.seeded(false);

  @override
  void initState() {
    super.initState();
    _firebaseBloc.add(LoadFirebaseDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RebornFilterBloc>.value(value: _rebornNameBloc),
        BlocProvider<FirebaseDataBloc>.value(value: _firebaseBloc),
      ],
      child: BaseScaffoldState(
        bottom: BottomNavigationView(tabBarBehaviour: _tabBehaviour),
        floating: StreamBuilder(
          builder: _getFilterClearWidget,
          stream: _filterClearBehavior.stream,
        ),
        floatLocation: FloatingActionButtonLocation.centerFloat,
        drawer: const MenuWidget(),
        body: SizedBox(
          height: screenData.height,
          child: StreamBuilder<List<TabBarData>>(
            stream: _tabBehaviour.stream,
            builder: _onBuildTabView,
          ),
        ),
      ),
    );
  }

  Widget _onBuildTabView(_, __) {
    return BlocBuilder<FirebaseDataBloc, FirebaseDataState>(
      builder: _onBuildGridFilter,
      bloc: _firebaseBloc,
    );
  }

  String _getTabId(final List<TabBarData> tabList) {
    return tabList.firstWhere((element) => element.isSelected).tabID;
  }

  Widget _getFilterClearWidget(
    final BuildContext context,
    final AsyncSnapshot<bool> filterActive,
  ) {
    if (filterActive.data == true) {
      return Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Ink(
            decoration: CCAppTheme.shadowNoBorder.copyWith(borderRadius: BorderRadius.all(Radius.circular(24))),
            width: 240,
            height: 48,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              child: InkWell(
                splashColor: CCAppTheme.periwinkleDarkColor.withAlpha(130),
                onTap: () {
                  _filterClearBehavior.sink.add(false);
                  _rebornNameBloc.add(
                    FilterRebornEvent(
                      searchData: LocalSearchData(
                        categories: [],
                        tracks: [],
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Clear Filter'),
                    const SizedBox(width: 12),
                    Icon(CupertinoIcons.clear_circled,
                        color: CCAppTheme.pinkDarkerColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    return const SizedBox();
  }

  Widget _onBuildGridFilter(
    final BuildContext context,
    final FirebaseDataState firebaseState,
  ) {
    if (firebaseState is FirebaseDataLoadingState) {
      return defaultLoader;
    }
    if (firebaseState is FirebaseDataReadyState) {
      final List<TabBarData> tabList = _tabBehaviour.valueOrNull ?? [];
      if (tabList.isNotEmpty) {
        final String tabId = _getTabId(tabList);
        if (tabId == StaticData.tabFavorite) {
          return const HomeFavoriteView();
        } else if (tabId == StaticData.tabSleeping) {
          final categories = firebaseState.sleepCategories;
          return HomeSleepView(
            categories: categories,
            key: GlobalKey(),
          );
        } else if (tabId == StaticData.tabCoaches) {
          return const HomeCoachView();
        } else if (tabId == StaticData.tabProfile) {
          return const HomeProfileView();
        }
      }
      return BlocBuilder(
        builder: _getFilterCategories,
        bloc: _rebornNameBloc,
      );
    }
    return const SizedBox();
  }

  Widget _getFilterCategories(
      final BuildContext context, final RebornFilterState state) {
    final firebaseState = _firebaseBloc.state as FirebaseDataReadyState;
    if (state is FilterLoadingState) {
      return defaultLoader;
    }
    if (state is FilterRebornState) {
      final categories = state.categories;
      _filterClearBehavior.sink.add(true);
      return CategoryListView(categories: categories,filterList: filterList,);
    }
    final categories = firebaseState.categories;
    return CategoryListView(categories: categories,filterList: filterList,);
  }

  @override
  void dispose() {
    _rebornNameBloc.close();
    _firebaseBloc.close();
    _filterClearBehavior.close();
    super.dispose();
  }
}
