import 'package:flutter/material.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/data_formatter.dart';
import 'package:reborn/utility/screen_data.dart';

import '../../domain/entities.dart';

class AudioPlayerBottomView extends StatefulWidget {
  final TrackEntity track;
  const AudioPlayerBottomView({
    Key? key,
    required this.track,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AudioPlayerBottomState();
  }
}

class _AudioPlayerBottomState extends State<AudioPlayerBottomView> {
  double sliderValue = 0;
  @override
  Widget build(BuildContext context) {
    final duration = DataFormatter.formattedDuration(Duration(seconds: widget.track.trackDuration));
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        height: 300,
        width: screenData.width - 48,
        decoration: CCAppTheme.shadowAudio, //.copyWith(borderRadius: rebornTheme.topRound),
        child: Column(
          children: [
            SizedBox(
              height: 175,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      height: 140,
                      width: 140,
                      decoration: CCAppTheme.circleBorderDec
                          .copyWith(color: CCAppTheme.periwinkleLightColor),
                    ),
                  ),
                  Center(
                    child: Row(
                      children: [
                        const SizedBox(width: 24),
                        _getTapWidget(_onBackwardAudio, Icons.fast_rewind),
                        const Expanded(child: SizedBox(), flex: 2),
                        _getTapWidget(_onBackwardAudio, Icons.play_arrow, dimension: 70),
                        const Expanded(child: SizedBox(), flex: 2),
                        _getTapWidget(_onBackwardAudio, Icons.fast_forward),
                        const SizedBox(width: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 125,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        duration,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 32,
                        ),
                      ),
                      _getTapWidget(
                        _onBackwardAudio,
                        Icons.favorite_border,
                        color: Colors.pinkAccent,
                      ),
                      Text(
                        "00:00",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    min: 0,
                    max: 1,
                    value: sliderValue,
                    onChanged: _onChanged,
                    inactiveColor: Colors.blueGrey,
                    thumbColor: Colors.white,
                    activeColor: CCAppTheme.pinkDarkerColor,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onChanged(final double value) {
    sliderValue = value;
  }

  void _onBackwardAudio() {}

  Widget _getTapWidget(final Function onTap, final IconData iconData,
      {final double dimension = 55.0, final Color color = const Color(0xFF7827E6)}) {
    return ClipRRect(
      borderRadius: CCAppTheme.brCircle,
      child: Material(
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
