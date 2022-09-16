


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/utility/screen_data.dart';

import '../../../utility/app_theme_data.dart';

class TrackGridView extends StatelessWidget {

  final TrackEntity track;
  const TrackGridView({Key? key, required this.track}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return  Material(
      borderRadius: const BorderRadius.all(Radius.circular(9)),
      color: Colors.transparent,
      child: Ink(
        color: Colors.transparent,
        width: screenData.width * 0.4,

        child: InkWell(
          focusColor: CCAppTheme.pinkLightColor,
          splashColor: CCAppTheme.periwinkleDarkColor,
          onTap: () {
            debugPrint("filter tap on ${track.trackTitle.en}");
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.music_note_sharp,
                  color: CCAppTheme.pinkLightColor),
              const SizedBox(height: 12),
              Text(track.trackTitle.en, style: CCAppTheme.txt1),
            ],
          ),
        ),
      ),
    );
  }
}