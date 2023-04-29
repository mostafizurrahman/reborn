import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reborn/feature/data_model/static_data.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/ui/audio_player/audio_player_screen.dart';
import 'package:reborn/feature/ui/widget/view_provider.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/image_ext.dart';
import 'package:reborn/utility/screen_data.dart';
import 'package:reborn/utility/user_info.dart';
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
                imageUrl:
                StaticData.coverImages[index],
                //  track.trackCoverImage,
                fit: BoxFit.cover,
                width: width * 0.8,
                height: width,
                errorWidget: (_, __, ___) =>
                    ImageExt.getDefaultCover(
                      width: width * 0.8,
                      height: width,
                    ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TrackCoverContent(trackEntity: track),
                ),
                if (author != null)
                  AuthorBlurView(
                    authorData: author,
                    authorTitleColor: Colors.white,
                  ),
              ],
            ),
            if (track.isPremium && !userInfo.isSubscribed) ViewProvider.getPremiumWidget(),
            Material(
              color: Colors.transparent,
              child: Ink(
                child: InkWell(
                  focusColor: CCAppTheme.pinkLightColor.withAlpha(80),
                  splashColor: CCAppTheme.periwinkleDarkColor.withAlpha(110),
                  onTap: () {
                    Navigator.of(context).pushNamed(AudioPlayerScreen.path,
                        arguments: {"track": track});
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
