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
      child: Stack(
        children: [
          Center(
            child: Container(
              height: 140,
              width: 140,
              decoration:
                  CCAppTheme.circleBorderDec.copyWith(color: CCAppTheme.periwinkleLightColor),
            ),
          ),
          Center(
            child: Row(
              children: [
                const SizedBox(width: 24),
                _getTapWidget(_onBackwardAudio, Icons.fast_rewind),
                Expanded(child: SizedBox(), flex: 2),
                _getTapWidget(_onBackwardAudio, Icons.play_arrow, dimension: 70),
                Expanded(child: SizedBox(), flex: 2),
                _getTapWidget(_onBackwardAudio, Icons.fast_forward),
                const SizedBox(width: 24),
              ],
            ),
          ),
          Positioned(
            child: Container(
              width: screenData.width,
              color: Colors.transparent,
              child: Center(
                child: Text(
                  "04:21",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 32,
                  ),
                ),
              ),
            ),
            top: 0,
            right: 0,
            left: 0,
          ),
          Positioned(
            child: Container(
              width: screenData.width,
              color: Colors.transparent,
              child: Center(
                child: Text(
                  "00:00",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 32,
                  ),
                ),
              ),
            ),
            bottom: 0,
            right: 0,
            left: 0,
          ),
          Positioned(
            child: _getTapWidget(_onBackwardAudio, Icons.favorite_border, color: Colors.pinkAccent),
            bottom: 0,
            right: 24,
          )
        ],
      ),
    );
  }

  void _onBackwardAudio() {}

  Widget _getTapWidget(final Function onTap, final IconData iconData,
      {final double dimension = 55.0, final Color color = const Color(0xFF7827E6)}) {
    return ClipRRect(
      borderRadius: CCAppTheme.brCircle,
      child:Material(
        child: Ink(
          decoration: CCAppTheme.circleBorderDec,
          width: dimension,
          height: dimension,
          child: InkWell(
            focusColor: Colors.blueAccent,
            splashColor: Colors.pinkAccent,
            onTap: () => onTap(),
            child: Center(
              child: Icon(
                iconData,
                size: dimension * 0.6,
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
