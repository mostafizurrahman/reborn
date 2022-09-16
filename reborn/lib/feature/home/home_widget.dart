import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:reborn/feature/data_model/entity/service_entity.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/home/home_recent_widget.dart';
import 'package:reborn/feature/home/home_secret_widget.dart';
import 'package:reborn/feature/home/home_tab_widget.dart';
import 'package:reborn/feature/home/rx_firebase_bloc/firebase_data_bloc.dart';
import 'package:reborn/feature/home/rx_firebase_bloc/firebase_data_events.dart';
import 'package:reborn/feature/home/rx_firebase_bloc/firebase_data_states.dart';
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
import '../base_widget/base_loading_view.dart';
import '../data/network/firebase_api.dart';
import '../data_model/static_data.dart';
import '../loading/rx_loading.dart';
import '../widget/base_widget/theme_state.dart';
import '../widget/ink_widget.dart';
import 'rx_reborn_name/reborn_name_bloc.dart';
import 'rx_reborn_name/reborn_name_states.dart';
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
        BlocProvider<FirebaseDataBloc>.value(value: _firebaseBloc),
      ],
      child: BaseScaffoldState(
        floating: BottomNavigationView(tabBarBehaviour: _tabBehaviour),
        floatLocation: FloatingActionButtonLocation.centerDocked,
        drawer: const MenuWidget(),
        body: SafeArea(
          child: SizedBox(
              height: screenData.height,
              child: BlocBuilder<FirebaseDataBloc, FirebaseDataState>(
                builder: _onBuildGridFilter,
                bloc: _firebaseBloc,
              )
              //   SingleChildScrollView(
              //   child: Column(
              //     children: [
              //       ,
              //     ],
              //   ),
              // ),
              ),
        ),
      ),
    );
  }

  Widget _onBuildGridFilter(final BuildContext _context, final FirebaseDataState firebaseState) {
    if (firebaseState is FirebaseDataLoadingState) {
      return SizedBox(
        height: screenData.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const RebornFilterView(),
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
      final categories = firebaseState.categories;
      return ListView.builder(
        itemBuilder: _getCategoryView,
        itemCount: categories.length + 1,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
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
