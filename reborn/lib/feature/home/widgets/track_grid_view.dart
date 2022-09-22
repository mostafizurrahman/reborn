import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/home/widgets/author_blur_view.dart';
import 'package:reborn/feature/widget/blur_round_view.dart';
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
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(9)),
      color: Colors.transparent,
      child: Ink(
        color: Colors.transparent,
        width: width * 0.65,
        height: width,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              child: CachedNetworkImage(
                imageUrl: "https://i.imgur.com/wXMqHQ2.jpg",
                fit: BoxFit.cover,
                width: width * 0.65,
                height: width,
                errorWidget: (_, __, ___) {
                  debugPrint("done");
                  return const Icon(
                    CupertinoIcons.person,
                    size: 60,
                  );
                },
              ),
            ),
            InkWell(
              focusColor: CCAppTheme.pinkLightColor,
              splashColor: CCAppTheme.periwinkleDarkColor,
              onTap: () {
                debugPrint("filter tap on ${track.trackTitle.en}");
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TrackGridContent(trackEntity: track),
                  ),
                  if (author != null) AuthorBlurView(authorData: author),
                ],
              ),
            ),
            if (track.isPremium) _getPremiumWidget(),
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
