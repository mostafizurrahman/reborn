import 'package:flutter/material.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/widget/view_provider.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/screen_data.dart';

class TrackGridContent extends StatelessWidget {
  final TrackEntity trackEntity;
  const TrackGridContent({Key? key, required this.trackEntity}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: rebornTheme.topRound,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.transparent],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(0.0, 2.0),
              stops: [0.0, 2.0],
              tileMode: TileMode.clamp
          ),
        ),
        width: screenData.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widgets,
        ),
      ),
    );
  }

  List<Widget> get widgets {
    final List<Widget> widgets = [const SizedBox(height: 8)];
    widgets.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ViewProvider.getCupertinoIcon(iconValue: trackEntity.trackIconData),
          Text(trackEntity.trackTitle.en, style: CCAppTheme.txtHL2)
        ],
      ),
    );
    widgets.add(const SizedBox(height: 4),);
    widgets.add(
      Text(trackEntity.trackSubtitle.en, style: CCAppTheme.txt2),
    );
    return widgets;
  }
}

class TrackCoverContent extends StatelessWidget {
  final TrackEntity trackEntity;
  const TrackCoverContent({Key? key, required this.trackEntity}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: rebornTheme.topRound,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.transparent],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(0.0, 2.0),
              stops: [0.0, 2.0],
              tileMode: TileMode.clamp
          ),
        ),
        width: screenData.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widgets,
        ),
      ),
    );
  }

  List<Widget> get widgets {
    final List<Widget> widgets = [const SizedBox(height: 24)];
    widgets.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ViewProvider.getCupertinoIcon(iconValue: trackEntity.trackIconData),
          Text(trackEntity.trackTitle.en, style: CCAppTheme.txtHL2)
        ],
      ),
    );
    widgets.add(const SizedBox(height: 8),);
    widgets.add(
      Text(trackEntity.trackSubtitle.en, style: CCAppTheme.txt2),
    );
    return widgets;
  }
}
