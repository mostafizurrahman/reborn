import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/widget/blur_round_view.dart';
import 'package:reborn/feature/widget/profile_view.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/screen_data.dart';

import '../../widget/view_provider.dart';

class TrackCategoryView extends StatelessWidget {
  final RebornCategory category;
  final CategorySummary summary;
  final double height;
  const TrackCategoryView({
    Key? key,
    required this.category,
    required this.height,
    required this.summary,
  }) : super(key: key);

  double get width => screenData.width - 48;

  @override
  Widget build(BuildContext context)  {

    return Container(
      decoration: CCAppTheme.shadowNoBorder,
      child: ClipRRect(
        borderRadius: circleRadius,
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              backgroundWidget,
              Container(
                decoration: decoration,
                child: Column(
                  children: [
                    titleWidget,
                    Text("Calm Tracks For Reborn",
                        style: CCAppTheme.txtHL1),
                    Expanded(
                      child: _getSummaryWidget(width),
                    ),
                    const Divider(height: 3, color: Colors.pinkAccent,),
                    SizedBox(
                      height: height * 0.3,
                      child: BlurRoundView(
                        content: _getAuthors(), radius: rebornTheme.bottomRound,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getSummaryWidget(final double width) {
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
            width: width / 3 - 3,
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

  Widget _getAuthors() {
    List<Widget> profiles = [];
    double x = 24;
    for (final author in summary.authors) {
      final profile = ProfileView(imagePath: author.profilePicture);
      final position = Positioned(
        child: Center(child: profile),

        left: x,
      );
      profiles.add(position);
      x += 35;
    }
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: profiles,
    );
  }

  Widget get titleWidget => Padding(
    padding: const EdgeInsets.only(top: 16, bottom: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ViewProvider.getCupertinoIcon(
          iconValue: category.logoData.toInt(),
          color: Colors.pinkAccent,
        ),
        const SizedBox(width: 12),
        Text(
          category.title.en,
          style: CCAppTheme.txtHL2.copyWith(color: Colors.pinkAccent),
        )
      ],
    ),
  );

  Widget get backgroundWidget => CachedNetworkImage(
    imageUrl: category.categoryCover ?? '', //  track.trackCoverImage,
    fit: BoxFit.cover,
    width: width,
    height: height,
    errorWidget: (_, __, ___) {
      debugPrint("done");
      return const Icon(
        CupertinoIcons.person,
        size: 60,
      );
    },
  );

  BorderRadius get circleRadius => const BorderRadius.all(Radius.circular(8));

  BoxDecoration get decoration => BoxDecoration(

    gradient: LinearGradient(
        colors: [Colors.white.withAlpha(200), Colors.transparent],
        begin: const FractionalOffset(0.0, 0.000),
        end: const FractionalOffset(0.0, 0.75),
        stops: const [0.0, 0.75],
        tileMode: TileMode.clamp),
  );
}
