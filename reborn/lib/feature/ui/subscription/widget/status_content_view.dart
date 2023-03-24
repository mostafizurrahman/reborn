import 'package:flutter/material.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/ui/subscription/widget/status_painter.dart';
import 'package:reborn/feature/ui/subscription/widget/status_verticle_view.dart';
import 'package:reborn/utility/app_theme_data.dart';

enum SVStatus {
  complete,
  incomplete,
  active,
}

class SVData {
  final int order;
  final IconData iconData;
  final double iconSize;
  final LocalizedText title;
  final LocalizedText description;
  final SVStatus status;
  SVData({
    required this.order,
    required this.iconData,
    required this.iconSize,
    this.status = SVStatus.complete,
    this.title = const LocalizedText(en: 'This is title', ru: 'This is title'),
    this.description = const LocalizedText(
      en: 'Your description or subtitle goes here. it should be some long',
      ru: 'Your description or subtitle goes here. it should be some long',
    ),
  });
}

class StatusContentView extends StatefulWidget {
  final double width;
  final int index;
  final List<SVData> verticleItems;

  const StatusContentView({
    Key? key,
    this.width = 80,
    required this.verticleItems,
    required this.index,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StatusContentState();
  }
}

class _StatusContentState extends State<StatusContentView> {
  final double _height = 100;
  @override
  void initState() {
    super.initState();
    widget.verticleItems.sort((final a, final b) => a.order.compareTo(b.order));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _getContents(),
    );
  }

  List<Widget> _getContents() {
    final List<Widget> widgets = [];

    for (final data in widget.verticleItems) {
      final statusWidget = _getStatusWidget(data: data);
      widgets.add(statusWidget);
    }
    return widgets;
  }

  Widget _getStatusWidget({required final SVData data}) {
    final title = Text(data.title.txt);
    final description = Text(data.description.txt);
    return Row(
      children: [
        StatusVerticleView(
          statusHeight: _height,
          statusData: data,
          width: 34,
        ),
        const SizedBox(width: 12),
        Expanded(
          child:SizedBox(
            height: _height,
            child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              title,
              const SizedBox(height: 8),
              description,
            ],
          ),
          ),
        ),
      ],
    );
  }
}
