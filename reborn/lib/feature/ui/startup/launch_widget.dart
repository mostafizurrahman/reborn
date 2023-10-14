import 'package:firebase_core/firebase_core.dart';
import 'package:reborn/feature/data_model/sqlite_manager.dart';
import 'package:reborn/feature/data_model/static_data.dart';
import 'package:reborn/feature/firebase/firebase_handler.dart';
import 'package:reborn/feature/ui/widget/index_widget.dart';
import 'package:reborn/firebase_options.dart';
import 'package:reborn/routing/app_route.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:reborn/utility/screen_data.dart';
import 'package:reborn/utility/user_info.dart';
import 'package:rxdart/rxdart.dart';
import '../widget/base_widget/theme_state.dart';
import '../widget/ink_widget.dart';
import 'welcome_page.dart';


class LaunchWidget extends StatefulWidget {
  const LaunchWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LaunchState();
  }
}

class _LaunchState extends ThemeState<LaunchWidget> {

  final BehaviorSubject<int> _pageBehaviour = BehaviorSubject();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenData.setScreenData(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/bg_light.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        width: screenData.width,
        height: screenData.height,
        child: SafeArea(
          child: Column(
            children: [
              // if (_pageBehaviour.value >= 0)
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
                child: StreamBuilder<int>(
                  stream: _pageBehaviour.stream,
                  builder: _getPageIndexWidget,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
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


  void _onIndexTapped(final int index) {
    debugPrint("tap index on $index");
    _pageBehaviour.sink.add(index);
  }

  Widget _getPageIndexWidget(
      final BuildContext context, final AsyncSnapshot<int> snapshot) {
    const double padding = 96;
    final pageDataList = StaticData.getPageData();
    final index = snapshot.data ?? 0;
    if (index == pageDataList.length - 1 ) {

      return  _getProceedButton("PROCEED ", Icons.arrow_circle_right,
          onTapInk: _openContactHome);
    }
    final dimension = (screenData.width - padding * 2 - 36 - 36) /
        (pageDataList.length * 1.5);
    final List<Widget> widgets = [const SizedBox(width: padding)];
    for (int index = 0; index < pageDataList.length; index++) {
      final widget = IndexWidget(
          index: index,
          onTap: _onIndexTapped,
          dimension: dimension,
          isSelected: index == index);
      widgets.add(widget);
    }
    widgets.add(const SizedBox(width: padding));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widgets,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageBehaviour.close();
  }
}
