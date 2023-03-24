import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reborn/feature/domain/category_summary.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/image_ext.dart';
import 'package:reborn/utility/screen_data.dart';

import '../../widget/view_provider.dart';

class ListCoverView extends StatelessWidget {
  final CategorySummary summary;
  const ListCoverView({
    Key? key,
    required this.summary,
  }) : super(key: key);

  double get _height => screenData.height * 0.24;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: screenData.width,
        height: _height,
        child: Stack(
          children: [
            _backgroundWidget(),
            Container(
              decoration: decoration,
              width: screenData.width,
              height: _height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  titleWidget,
                  _getSummaryWidget(),
                  const SizedBox(height: 8)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _backgroundWidget() {
    return CachedNetworkImage(
      imageUrl: summary.coverImage ?? '',
      //  track.trackCoverImage,
      fit: BoxFit.cover,
      width: screenData.width,
      height: _height,
      errorWidget: (_, __, ___) {
        debugPrint("done");
        return ImageExt.getDefaultCover(
          width: screenData.width,
          height: _height,
        );
      },
    );
  }

  BoxDecoration get decoration => BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.white.withAlpha(200), Colors.transparent],
            begin: const FractionalOffset(0.0, 0.9),
            end: const FractionalOffset(0.0, 0.0),
            stops: const [0.0, 1.0],
            tileMode: TileMode.clamp),
      );

  Widget _getSummaryWidget() {
    final len = summary.summary.length;
    return Row(
      children: List<Widget>.generate(
        len + 2,
        (index) {
          if (index == 1 || index == 3) {
            return Container(
              color: Colors.pinkAccent,
              width: 1.5,
              height: 30,
            );
          }
          return SizedBox(
            width: screenData.width / 3 - 3,
            child: Center(
              child: Text(
                summary.summary[index % len],
                style: CCAppTheme.txtReg,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget get titleWidget {
    late Icon icon;
    if (summary.logoData == -1) {
      icon = const Icon(CupertinoIcons.music_albums);
    } else {
      icon = ViewProvider.getCupertinoIcon(
        iconValue: summary.logoData.toInt(),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 12),
          Text(
            summary.title.txt,
            style: CCAppTheme.txtHL2,
          )
        ],
      ),
    );
  }
}
