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
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/screen_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../base_widget/base_loading_view.dart';
import 'rx_reborn_name/reborn_name_bloc.dart';
import 'widgets/bottom_navigation_view.dart';
import 'widgets/reborn_category_view.dart';
import 'widgets/reborn_filter_view.dart';

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
    screenData.setScreenData(context);

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
      return SizedBox(
        height: screenData.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //const RebornFilterView(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: BaseLoadingView.loader,
            ),
            Text(
              "Loading...",
              style: CCAppTheme.txtHL2,
            ),
          ],
        ),
      );
    }
    if (firebaseState is FirebaseDataReadyState) {
      final List<TabBarData> tabList = _tabBehaviour.valueOrNull ?? [];
      if (tabList.isNotEmpty) {
        final String tabId = _getTabId(tabList);
        if (tabId == StaticData.tabFavorite) {
          return const HomeFavoriteView();
        } else if (tabId == StaticData.tabSleeping) {
          return const HomeSleepView();
        } else if (tabId == StaticData.tabCoaches) {
          return const HomeCoachView();
        } else if (tabId == StaticData.tabProfile) {
          return const HomeProfileView();
        }
      }
      final categories = firebaseState.categories;
      return ScrollConfiguration(
        behavior: HorizontalScrollBehavior(),
        child: ListView.builder(
          itemBuilder: _getCategoryView,
          itemCount: categories.length + 1,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
        ),
      );
    }
    return const SizedBox();
  }

  Widget _getCategoryView(final BuildContext listContext, final int _index) {
    if (_index == 0) {
      return const RebornFilterView();
    }
    final FirebaseDataReadyState firebaseState = _firebaseBloc.state as FirebaseDataReadyState;
    final RebornCategory category = firebaseState.categories[_index - 1];
    final padding = screenData.getHomeVerticalPadding(firebaseState.categories.length, _index - 1);
    return Padding(
      padding: padding,
      child: RebornCategoryView(
        firebaseState: firebaseState,
        category: category,
      ),
    );
  }

  @override
  void dispose() {
    _rebornNameBloc.close();
    _firebaseBloc.close();
    super.dispose();
  }
}
