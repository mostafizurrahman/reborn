


import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reborn/feature/audio_player/audio_player_screen.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/utility/image_ext.dart';
import 'package:reborn/utility/screen_data.dart';

import '../../../utility/app_theme_data.dart';
import '../../data_model/static_data.dart';
import 'author_blur_view.dart';
import 'track_grid_content.dart';

class TrackCoverView extends StatelessWidget {

  final TrackEntity track;
  const TrackCoverView({Key? key, required this.track}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final author = track.trackAuthor;
    final width = screenData.width;
    var rng = Random();
    int index = rng.nextInt(StaticData.coverImages.length);

    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(9)),
      color: Colors.transparent,
      child: Container(
        color: Colors.transparent,
        width: width * 0.8,
        height: width,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              child: CachedNetworkImage(
                imageUrl: StaticData.coverImages[index], //  track.trackCoverImage,
                fit: BoxFit.cover,
                width: width * 0.8,
                height: width,
                errorWidget: (_, __, ___) => ImageExt.getDefaultCover(width: width * 0.8, height: width,),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TrackCoverContent(trackEntity: track),
                ),
                if (author != null) AuthorBlurView(authorData: author, authorTitleColor: Colors.white,),
              ],
            ),
            if (track.isPremium) _getPremiumWidget(),
            Material(
              color: Colors.transparent,
              child: Ink(
                child: InkWell(
                  focusColor: CCAppTheme.pinkLightColor.withAlpha(80),
                  splashColor: CCAppTheme.periwinkleDarkColor.withAlpha(110),
                  onTap: () {
                    Navigator.of(context).pushNamed(AudioPlayerScreen.path, arguments: {"track" : track});
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPremiumWidget() {
    return Row(
      children: const [
        Expanded(child: SizedBox()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          child: Icon(Icons.lock_outline_rounded, size: 18),
        ),
      ],
    );
  }


  // @override
  // Widget build(BuildContext context) {
  //
  //   return  Material(
  //     borderRadius: const BorderRadius.all(Radius.circular(9)),
  //     color: Colors.transparent,
  //     child: Ink(
  //       color: Colors.transparent,
  //       width: screenData.width * 0.75,
  //
  //       child: InkWell(
  //         focusColor: CCAppTheme.pinkLightColor,
  //         splashColor: CCAppTheme.periwinkleDarkColor,
  //         onTap: () {
  //           debugPrint("filter tap on ${track.trackTitle.en}");
  //         },
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Icon(Icons.music_note_sharp,
  //                 color: CCAppTheme.pinkLightColor),
  //             const SizedBox(height: 12),
  //             Text(track.trackTitle.en, style: CCAppTheme.txt1),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}