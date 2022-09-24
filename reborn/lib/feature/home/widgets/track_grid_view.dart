import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reborn/feature/audio_player/audio_player_screen.dart';
import 'package:reborn/feature/data_model/static_data.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/home/widgets/author_blur_view.dart';
import 'package:reborn/feature/widget/blur_round_view.dart';
import 'package:reborn/utility/image_ext.dart';
import 'package:reborn/utility/screen_data.dart';

import '../../../utility/app_theme_data.dart';
import 'track_grid_content.dart';

class TrackGridView extends StatelessWidget {
  final TrackEntity track;
  const TrackGridView({Key? key, required this.track}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final author = track.trackAuthor;
    final width = screenData.width;
    var rng = Random();
    int index = rng.nextInt(StaticData.gridImages.length);

    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(9)),
      color: Colors.transparent,
      child: Container(
        color: Colors.transparent,
        width: width * 0.65,
        height: width,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              child: CachedNetworkImage(
                imageUrl: StaticData.gridImages[index], //  track.trackCoverImage,
                fit: BoxFit.cover,
                width: width * 0.65,
                height: width,
                errorWidget: (_, __, ___) {
                  return ImageExt.getDefaultGrid(width: width * 0.65, height: width);
                },
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TrackGridContent(trackEntity: track),
                ),
                if (author != null) AuthorBlurView(authorData: author),
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
}
