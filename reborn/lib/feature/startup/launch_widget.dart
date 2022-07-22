import 'dart:async';

import 'package:reborn/feature/data_model/static_data.dart';
import 'package:reborn/feature/startup/rx_launch/launch_bloc.dart';
import 'package:reborn/feature/widget/index_widget.dart';
import 'package:reborn/routing/app_route.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

import '../../utility/screen_data.dart';
import '../widget/base_widget/theme_state.dart';
import '../widget/ink_widget.dart';
import 'rx_launch/launch_events.dart';
import 'rx_launch/launch_states.dart';
import 'welcome_page.dart';

class LaunchWidget extends StatefulWidget {
  const LaunchWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LaunchState();
  }
}

class _LaunchState extends ThemeState<LaunchWidget> {
  final _launchBloc = LaunchBloc();
  final BehaviorSubject<int> _pageBehaviour = BehaviorSubject();
  late final StreamSubscription blocSubscription;
  @override
  void initState() {
    super.initState();
    _launchBloc.add(ContactPermissionEvent());
    // blocSubscription = launchBloc.stream.listen(_onL)
  }

  @override
  Widget build(BuildContext context) {
    screenData.setScreenData(context);
    return Scaffold(
      body: Container(
        width: screenData.width,
        height: screenData.height,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                width: screenData.width,
                height: screenData.height * 0.75,
                child: WelcomePage(pageBehaviour: _pageBehaviour),
              ),
              const Expanded(child: SizedBox()),
              Container(
                width: screenData.width - 32,
                height: 75,
                decoration: CCAppTheme.shadowDec,
                child: _getBlocWidget(),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
        color: Colors.white,
      ),
    );
  }

  Widget _getBlocWidget() {
    return BlocBuilder(
      bloc: _launchBloc,
      builder: _getLaunchBloc,
    );
  }

  Widget _getLaunchBloc(BuildContext _context, LaunchState state) {
    if (state is LoadingLaunchState) {
      return _loadingWidget;
    }
    if (state is ContactPermissionState) {
      if (state.permissionStatus == PermissionStatus.granted) {
        _launchBloc.add(ReadContactEvent());
      } else {
        _launchBloc.add(PermissionRequestEvent());
        return _loadingWidget;
      }
    }
    if (state is PermissionRequestState) {
      if (state.permissionStatus != PermissionStatus.granted) {
        return _getProceedButton("OPEN  PERMISSION", Icons.settings,
            onTapInk: _openPermissionSettings);
      }
    }
    if (state is LoadingContactState) {
      return _getProceedButton("UPDATING CONTACT", Icons.person_sharp);
    }
    if (state is ReadContactState) {
      return _getProceedButton("PROCEED ", Icons.arrow_circle_right,
          onTapInk: _openContactHome);
    }
    return StreamBuilder<int>(
      stream: _pageBehaviour.stream,
      builder: _getPageIndexWidget,
    );
  }

  Widget _getProceedButton(final String title, final IconData iconData,
      {final VoidCallback? onTapInk}) {
    return InkWidget(
      onTap: onTapInk, //onTapInk,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (onTapInk == null)
            const Padding(
              padding: EdgeInsets.only(right: 12),
              child: CircularProgressIndicator(),
            ),
          Text(title, style: headStyle2.copyWith(color: Colors.pinkAccent)),
          const SizedBox(width: 16),
          Icon(iconData, color: Colors.blueAccent),
        ],
      ),
      height: 70,
      dimension: screenData.width - 48,
    );
  }

  void _openContactHome() {
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  void _openPermissionSettings() {
    openAppSettings();
  }

  void _onIndexTapped(final int index) {
    debugPrint("tap index on $index");
    _pageBehaviour.sink.add(index);
    if (index == StaticData.getPageData().length - 1) {
      _launchBloc.add(ReadContactEvent());
    }
  }

  Widget _getPageIndexWidget(
      final BuildContext _context, final AsyncSnapshot<int> _snapshot) {
    const double padding = 96;
    final pageDataList = StaticData.getPageData();
    final _index = _snapshot.data ?? 0;
    if (_index == pageDataList.length - 1 ) {
      Future.delayed(const Duration(seconds: 1), () => _launchBloc.add(ReadContactEvent()));
    }
    final dimension = (screenData.width - padding * 2 - 36 - 36) /
        (pageDataList.length * 1.5);
    final List<Widget> _widgets = [const SizedBox(width: padding)];
    for (int index = 0; index < pageDataList.length; index++) {
      final _widget = IndexWidget(
          index: index,
          onTap: _onIndexTapped,
          dimension: dimension,
          isSelected: index == _index);
      _widgets.add(_widget);
    }
    _widgets.add(const SizedBox(width: padding));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _widgets,
    );
  }

  Widget get _loadingWidget {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageBehaviour.close();
  }
}
