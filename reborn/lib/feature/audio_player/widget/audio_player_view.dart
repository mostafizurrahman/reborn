import 'package:flutter/material.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/screen_data.dart';

class AudioPlayerView extends StatefulWidget {
  final TrackEntity track;
  const AudioPlayerView({
    Key? key,
    required this.track,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AudioPlayerState();
  }
}

class _AudioPlayerState extends State<AudioPlayerView> {
  double durationInMilSec = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      width: screenData.width,
    );
  }


}
