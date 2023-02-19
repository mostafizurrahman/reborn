import 'package:reborn/feature/data_model/static_data.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/ui/base_widget/base_scaffold_state.dart';
import 'package:reborn/feature/ui/favorites/home_favorite_view.dart';
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

  final BehaviorSubject<List<TabBarData>> _tabBehaviour = BehaviorSubject();
  final RebornFilterBloc _rebornNameBloc = RebornFilterBloc();
  final FirebaseDataBloc _firebaseBloc = FirebaseDataBloc();

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
        floating: BottomNavigationView(tabBarBehaviour: _tabBehaviour),
        floatLocation: FloatingActionButtonLocation.centerDocked,
        drawer: const MenuWidget(),
        body: SafeArea(
          child: SizedBox(
            height: screenData.height,
            child: StreamBuilder<List<TabBarData>>(
              stream: _tabBehaviour.stream,
              builder: _onBuildTabView,
            ),
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

  Widget _onBuildGridFilter(final BuildContext _context, final FirebaseDataState firebaseState) {
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
          return HomeSleepView(categories: categories, key: GlobalKey(),);
        } else if (tabId == StaticData.tabCoaches) {
          return const HomeCoachView();
        } else if (tabId == StaticData.tabProfile) {
          return const HomeProfileView();
        }
      }
      final categories = firebaseState.categories;
      return CategoryListView(categories: categories);
    }
    return const SizedBox();
  }



  @override
  void dispose() {
    _rebornNameBloc.close();
    _firebaseBloc.close();
    super.dispose();
  }
}
