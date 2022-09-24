import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reborn/feature/audio_player/audio_player_screen.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/home/widgets/author_blur_view.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/data_formatter.dart';
import 'package:reborn/utility/image_ext.dart';
import 'package:reborn/utility/screen_data.dart';


class TrackItemView extends StatelessWidget {
  final TrackEntity track;
  final double _width = 120;
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
          height: _height,
          decoration: CCAppTheme.trackDecoration,
          child: Stack(
            children: [
              Row(
                children: [
                  const SizedBox(width: 12),
                  _getTrackImage(),
                  const SizedBox(width: 12),
                  Expanded(child: _getTextContent()),
                ],
              ),
              Positioned(child: _tapWidget(context), left: 0, right: 0, top: 0, bottom:0,),
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
        const SizedBox(height: 12),
        Text(track.trackTitle.en, style: CCAppTheme.txtHL2),
        const SizedBox(height: 4),
        Text(track.trackSubtitle.en,
            style: CCAppTheme.txt1
                .copyWith(fontWeight: FontWeight.bold, color: CCAppTheme.pinkDarkerColor)),
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
        if (track.trackAuthor != null) AuthorLeftRoundView(authorData: track.trackAuthor!),
      ],
    );
  }

  Widget _getSummaryText() {
    final duration = DataFormatter.formattedDuration(Duration(seconds: track.trackDuration));
    final gener = track.generList.isNotEmpty ? track.generList.first : 'Meditation';
    final loved = track.playerInfo.likeCount;
    final List<String> summary = ["$duration Min", "|", gener.split(" ").first, "|", "$loved ❤"];
    final List<double> widthList = [75, 2.5, 100, 2.5, 75];
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
              style: CCAppTheme.txtReg.copyWith(
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

  Widget _tapWidget(BuildContext context) => Material(
    color: Colors.transparent,
    child: Ink(
      child: InkWell(
        focusColor: CCAppTheme.pinkLightColor.withAlpha(80),
        splashColor: CCAppTheme.periwinkleDarkColor.withAlpha(110),
        onTap: () {
          Navigator.pushNamed(context, AudioPlayerScreen.path, arguments: {
            "track": track,
          });
          debugPrint("track tap on ${track.trackTitle.en}");
        },
      ),
    ),
  );
}
