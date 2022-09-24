import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/home/widgets/author_blur_view.dart';
import 'package:reborn/feature/widget/blur_round_view.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/image_ext.dart';
import 'package:reborn/utility/screen_data.dart';

import '../../data_model/static_data.dart';

class TrackItemView extends StatelessWidget {

  final TrackEntity track;
  final double _width = 130;
  final double _height = 175;

  const TrackItemView({
    Key? key,
    required this.track,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: screenData.width,
          height: _height ,
          decoration: CCAppTheme.trackDecoration,
          child: Stack(
            children: [
              Row(
                children: [
                  _getTrackImage(),
                  const SizedBox(width: 12),
                  Expanded(child: _getTextContent()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTextContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(track.trackTitle.en, style: CCAppTheme.txtHL3),
        const SizedBox(height: 4),
        Text(track.trackSubtitle.en, style: CCAppTheme.txt),
        const SizedBox(height: 12),
        if (track.trackAuthor != null) AuthorLeftRoundView(authorData: track.trackAuthor!),
      ],
    );
  }

  Widget _getTrackImage() {
    if (track.isLocalTrack) {
      return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: ImageExt.get(track.trackCoverImage, widgetWidth: _width, widgetHeight: _height),
      );
    }

    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: CachedNetworkImage(
        imageUrl: track.trackCoverImage, //  track.trackCoverImage,
        fit: BoxFit.cover,
        width: _width,
        height: _height,
        errorWidget: (_, __, ___) {
          return ImageExt.getDefaultGrid(width: _width, height: _height);
        },
      ),
    );
  }
}
