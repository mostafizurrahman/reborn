import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'dart:ui';

import 'package:reborn/utility/screen_data.dart';


class DialogContent {
  final LocalizedText title;
  final LocalizedText? subtitle;
  final LocalizedText description;
  final LocalizedText yesTitle;
  final LocalizedText noTitle;
  final LocalizedText doneTitle;
  final bool useDoneOnly;
  final IconData iconData;
  DialogContent({
    required this.title,
    required this.description,
    this.subtitle,
    this.useDoneOnly = true,
    this.noTitle = const LocalizedText(ru: 'НЕТ', en: 'NO'),
    this.yesTitle = const LocalizedText(ru: 'ДА', en: 'YES'),
    this.doneTitle = const LocalizedText(ru: 'ДА', en: 'DONE'),
    this.iconData = CupertinoIcons.info_circle_fill,
  });
}

abstract class DialogTapInterface {
  void onTapYes();
  void onTapClose();

  void onTapNo() {}

  void onOtherOptionTapped() {}
}

class BottomDialogWidget extends StatefulWidget {
  final DialogTapInterface tapInterface;
  final DialogContent content;
  const BottomDialogWidget({
    Key? key,
    required this.tapInterface,
    required this.content,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BottomDialogState();
  }
}

class BottomDialogState extends State<BottomDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(child: SizedBox()),
            //title-view
            _TitleView(
              tapInterface: widget.tapInterface,
              content: widget.content,
            ),
            _BodyTextView(
              content: widget.content,
            ),

            Container(
              color: Colors.white,
              height: 70,
              child: _ActionView(
                tapInterface: widget.tapInterface,
                content: widget.content,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TitleView extends StatelessWidget {
  final DialogTapInterface tapInterface;
  final DialogContent content;
  const _TitleView({
    Key? key,
    required this.tapInterface,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: CCAppTheme.topRound12,
      child: Container(
        color: Colors.grey.shade200,
        width: screenData.width,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  child: Icon(
                    content.iconData,
                    color: Colors.grey,
                    size: 40,
                  ),
                ),
                Expanded(
                  child: Text(
                    content.title.txt,
                    style: CCAppTheme.txtHL2,
                  ),
                ),
                ClipRRect(
                  borderRadius: CCAppTheme.circleRadius,
                  child: Material(
                    child: Ink(
                      width: 50,
                      height: 50,
                      color: Colors.white,
                      child: InkWell(
                        onTap: tapInterface.onTapClose,
                        splashColor: CCAppTheme.periwinkleLightColor,
                        highlightColor: CCAppTheme.pinkDarkColor.withAlpha(150),
                        child: const Center(
                          child: Icon(
                            CupertinoIcons.clear_circled,
                            color: Colors.black54,
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BodyTextView extends StatelessWidget {
  final DialogContent content;
  const _BodyTextView({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: screenData.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          ..._getSubtitles(),
          ..._getBodyContent(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  List<Widget> _getSubtitles() {
    final List<Widget> widgets = [];
    if (content.subtitle != null) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            content.subtitle!.txt,
            style: CCAppTheme.txtReg,
          ),
        ),
      );
    }
    return widgets;
  }

  List<Widget> _getBodyContent() {
    final List<Widget> widgets = [];
    widgets.add(
      Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          content.description.txt,
          style: CCAppTheme.txt2,
        ),
      ),
    );
    return widgets;
  }
}

class _ActionView extends StatelessWidget {
  final DialogTapInterface tapInterface;
  final DialogContent content;
  const _ActionView({
    Key? key,
    required this.tapInterface,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenData.width,
      color: Colors.white,
      height: 70,
      child: Row(
        children: _getActions(),
      ),
    );
  }

  List<Widget> _getActions() {
    final List<Widget> widgets = [];
    if (content.useDoneOnly) {
      final doneWidget =
          _getActionWidget(content.doneTitle.txt, tapInterface.onTapClose);
      widgets.add(
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: doneWidget,
          ),
        ),
      );
    } else {
      final yesWidget =
          _getActionWidget(content.yesTitle.txt, tapInterface.onTapYes);
      final noWidget =
          _getActionWidget(content.noTitle.txt, tapInterface.onTapNo);
      widgets.add(
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: yesWidget,
          ),
        ),
      );
      widgets.add(
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: noWidget,
          ),
        ),
      );
    }
    return widgets;
  }

  Widget _getActionWidget(final String title, final VoidCallback onTap) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Material(
        child: Ink(
          height: 60,
          decoration: CCAppTheme.shadowDec,
          child: InkWell(
            splashColor: CCAppTheme.periwinkleLightColor,
            highlightColor: CCAppTheme.pinkDarkColor.withAlpha(150),
            onTap: onTap,
            child: Center(
              child: Text(
                title,
                style: CCAppTheme.txtHL1.copyWith(fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
