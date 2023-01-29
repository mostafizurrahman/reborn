import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/feature/ui/base_widget/base_loading_view.dart';
import 'package:reborn/feature/ui/loading/rx_loading.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/screen_data.dart';

class BaseScaffoldState extends StatelessWidget {
  final Widget? body;
  final Widget? bottom;
  final Widget? floating;
  final Widget? drawer;
  final PreferredSizeWidget? appBar;
  final FloatingActionButtonLocation? floatLocation;

  const BaseScaffoldState({
    Key? key,
    this.body,
    this.bottom,
    this.floating,
    this.floatLocation,
    this.appBar,
    this.drawer,
  }) : super(key: key);

  Future<bool> onWilPop() async {
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: loadingBloc,
      child: WillPopScope(
        onWillPop: onWilPop,
        child: Scaffold(
          drawer: drawer,
          appBar: appBar,
          body: Container(
            width: screenData.width,
            height: screenData.height,
            decoration: rebornTheme.decoration,
            child: BlocBuilder(
              bloc: loadingBloc,
              builder: _onLoadingWidget,
            ),
          ),
          bottomNavigationBar: bottom,
          floatingActionButton: floating,
          floatingActionButtonLocation: floatLocation,
        ),
      ),
    );
  }

  Widget _onLoadingWidget(final BuildContext context, final LoadingState state) {
    if (state is LoadingStartState || state is LoadingErrorState) {
      return Stack(
        children: [
          body ?? Container(),
          BaseLoadingView(loadingState: state),
        ],
      );
    }
    return body ?? Container();
  }


}
