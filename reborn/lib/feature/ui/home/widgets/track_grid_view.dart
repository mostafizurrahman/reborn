import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/ui/audio_player/audio_player_screen.dart';
import 'package:reborn/feature/ui/home/widgets/author_blur_view.dart';
import 'package:reborn/feature/ui/widget/view_provider.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/image_ext.dart';
import 'package:reborn/utility/screen_data.dart';
import 'package:reborn/utility/user_info.dart';
import '../../subscription/subscription_page.dart';
import 'track_grid_content.dart';

class TrackGridView extends StatelessWidget {
  final TrackEntity track;
  const TrackGridView({Key? key, required this.track}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final author = track.trackAuthor;
    final width = screenData.width;

    final itemWidth = width * 0.7;
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(9)),
      color: Colors.transparent,
      child: Container(
        color: Colors.transparent,
        width: itemWidth,
        height: width,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              child: CachedNetworkImage(
                imageUrl: track.trackCoverImage, //  track.trackCoverImage,
                fit: BoxFit.fitWidth,
                width: itemWidth,
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
            if (track.isPremium && !userInfo.isSubscribed) ViewProvider.getPremiumWidget(),
            Material(
              color: Colors.transparent,
              child: Ink(
                child: InkWell(
                  focusColor: CCAppTheme.pinkLightColor.withAlpha(80),
                  splashColor: CCAppTheme.periwinkleDarkColor.withAlpha(110),
                  onTap: () {
                    if (track.isPremium && !userInfo.isSubscribed) {
                      Navigator.push(context, MaterialPageRoute(builder: (_){return SubscriptionPage();}));
                    } else {
                      Navigator.of(context).pushNamed(AudioPlayerScreen.path, arguments: {"track" : track});
                    }
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
