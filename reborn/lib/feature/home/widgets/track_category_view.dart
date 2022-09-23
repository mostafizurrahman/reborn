import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/widget/profile_view.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/screen_data.dart';

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

  @override
  Widget build(BuildContext context) {
    final double width = screenData.width - 48;
    return Material(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              CachedNetworkImage(
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
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.white, Colors.transparent],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(0.0, 2.0),
                      stops: [0.0, 2.0],
                      tileMode: TileMode.clamp),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        category.title.en,
                        style: CCAppTheme.txtHL2.copyWith(color: Colors.pinkAccent),
                      ),
                    ),
                    Text("Track List For Reborn",
                        style: CCAppTheme.txtReg.copyWith(color: Colors.deepPurple)),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: summary.summary[0],
                          style:
                              DefaultTextStyle.of(context).style.copyWith(color: Colors.pinkAccent),
                          children: <TextSpan>[
                            TextSpan(
                              text: summary.summary[1],
                              style: CCAppTheme.txtHL3.copyWith(color: Colors.deepPurple),
                            ),
                            TextSpan(
                              text: summary.summary[2],
                              style: CCAppTheme.txt2.copyWith(color: Colors.pinkAccent),
                            ),
                          ],
                        ),
                      ),

                      // Text(
                      //   summary.duration,
                      //   style: CCAppTheme.txt2.copyWith(color: Colors.pinkAccent),
                      // ),
                    ),
                    Divider(height: 3),
                    SizedBox(
                      height: height * 0.2,
                      child: _getAuthors(),
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

  Widget _getAuthors() {
    List<Widget> profiles = [];
    double x = 24;
    double vertical = height * 0.2 / 2 - 25;
    for (final author in summary.authors) {
      final profile = ProfileView(imagePath: author.profilePicture);
      final position = Positioned(
        child: profile,
        top: vertical,
        bottom: vertical,
        left: x,
      );
      profiles.add(position);
      x += 40;
    }
    return Stack(
      children: profiles,
    );
  }
}
