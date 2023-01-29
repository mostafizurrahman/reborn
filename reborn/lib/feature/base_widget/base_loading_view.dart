
import 'package:flutter/material.dart';
import 'package:reborn/feature/loading/rx_loading.dart';
import 'package:reborn/feature/ui/widget/blur_round_view.dart';
import 'package:reborn/utility/app_theme_data.dart';

class BaseLoadingView extends StatelessWidget {
  final LoadingState loadingState;
  const BaseLoadingView({Key? key, required this.loadingState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDismiss = loadingState.shouldDismiss;
    return WillPopScope(
      child: Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        child:BlurRoundView(
          radius: rebornTheme.topRound,
          content: Padding(
            padding: const EdgeInsets.all(12),
            child: _generateBody(),
          ),
        ),
      ),
      onWillPop: () async => Future.value(isDismiss),
    );
  }

  Widget _generateBody() {
    final state = loadingState;
    if (state is LoadingErrorState) {
      Column(
        children:  [
          Text(state.errorText),
          loader,
        ],
      );
    }
    return Column(
      children: [
        Text("Loading...", style: CCAppTheme.txtHL2,),
        loader,
      ],
    );
  }

  static Widget get loader => const SizedBox(
    child: CircularProgressIndicator(
      strokeWidth: 2,
      backgroundColor: Colors.pink,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
    ),
  );
}
