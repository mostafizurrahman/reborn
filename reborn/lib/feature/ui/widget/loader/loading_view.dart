import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/screen_data.dart';

class _LoadingView extends StatelessWidget {
  const _LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Column(
          children: [
            const Expanded(child: SizedBox()),
            Container(
              width: screenData.width,
              decoration: CCAppTheme.shadowNoBorder.copyWith(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              height: 259,
              child: LoadingAnimationWidget.twistingDots(
                leftDotColor: const Color(0xFF1A1A3F),
                rightDotColor: const Color(0xFFEA3799),
                size: 200,
              ),
            )
          ],
        ),
      ),
    );
  }
}

void startLoading(final BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (final BuildContext ctx) {
        return WillPopScope(
          child: const _LoadingView(),
          onWillPop: () async => false,
        );
      },
  );
}

Future<void> stopLoading(final BuildContext context) async {
  Navigator.of(context).pop();
}