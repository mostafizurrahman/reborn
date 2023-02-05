import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/ui/audio_player/audio_player_screen.dart';
import 'package:reborn/feature/ui/home/widgets/author_blur_view.dart';
import 'package:reborn/feature/ui/widget/action_widget.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/data_formatter.dart';
import 'package:reborn/utility/image_ext.dart';
import 'package:reborn/utility/screen_data.dart';

class TrackItemView extends StatelessWidget {
  final TrackEntity track;
  final double _width = 100;
  final double _height = 175;
  final Function(TrackEntity)? onTap;
  const TrackItemView({
    Key? key,
    required this.track,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: screenData.width,
          height: _height,
          decoration: CCAppTheme.trackDecoration,
          child: Stack(
            children: [
              SizedBox(
                width: screenData.width,
                height: _height,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _getTrackImage(),
                          const SizedBox(width: 12),
                          Expanded(child: _getTextContent()),
                        ],
                      ),
                    ),
                    if (track.trackAuthor != null)
                      AuthorLeftRoundView(authorData: track.trackAuthor!),
                  ],
                ),
              ),
              // Positioned(left: 0, right: 0, top: 0, bottom:0,child: Column(

              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: ActionWidget(onTap: startTrack),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startTrack(){
    final tapFunc = onTap;
    if (tapFunc != null) {
      tapFunc(track);
    }
  }

  Widget _getTextContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(track.trackTitle.en, style: CCAppTheme.txtHL3),
        const SizedBox(height: 4),
        Text(track.trackSubtitle.en,
            style: CCAppTheme.txt.copyWith(
                fontWeight: FontWeight.bold,
                color: CCAppTheme.pinkDarkerColor)),
        const SizedBox(height: 12),
        const Expanded(child: SizedBox()),
        _getSummaryText(),
        const SizedBox(
          height: 12,
          child: Divider(
            height: 4,
            color: Colors.pinkAccent,
          ),
        ),
      ],
    );
  }

  Widget _getSummaryText() {
    final duration =
        DataFormatter.formattedDuration(Duration(seconds: track.trackDuration));
    final gener =
        track.generList.isNotEmpty ? track.generList.first : 'Meditation';
    final loved = track.playerInfo.likeCount;
    final List<String> summary = [
      duration,
      "|",
      gener.split(" ").first,
      "|",
      "$loved ❤"
    ];
    final List<double> widthList = [65, 2.5, 95, 2.5, 65];
    final List<Color> colors = [
      Colors.black,
      Colors.pinkAccent,
      Colors.black,
      Colors.pinkAccent,
      Colors.black,
    ];
    final List<FontWeight> weights = [
      FontWeight.w500,
      FontWeight.bold,
      FontWeight.w500,
      FontWeight.bold,
      FontWeight.w500,
    ];
    return Row(
      children: List<Widget>.generate(
        5,
        (index) => SizedBox(
          width: widthList[index],
          child: Center(
            child: Text(
              summary[index],
              style: CCAppTheme.txt.copyWith(
                color: colors[index],
                fontWeight: weights[index],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getTrackImage() {
    if (track.isLocalTrack) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12), bottomRight: Radius.circular(12),),
        child: ImageExt.get(track.trackCoverImage,
            widgetWidth: _width, widgetHeight: _width),
      );
    }

    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12), bottomRight: Radius.circular(12),),
      child: CachedNetworkImage(
        imageUrl: track.trackCoverImage, //  track.trackCoverImage,
        fit: BoxFit.cover,
        width: _width,
        height: _width,
        errorWidget: (_, __, ___) {
          return ImageExt.getDefaultGrid(width: _width, height: _width);
        },
      ),
    );
  }



}
