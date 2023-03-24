import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/ui/base_widget/base_scaffold_state.dart';
import 'package:reborn/feature/ui/widget/profile_view.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/data_formatter.dart';
import 'package:reborn/utility/screen_data.dart';

class AuthorDetailsPage extends StatefulWidget {
  final RebornAuthor author;
  const AuthorDetailsPage({Key? key, required this.author}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AuthorDetailsState();
  }
}

class _AuthorDetailsState extends State<AuthorDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldState(
      appBar: AppBar(
        backgroundColor: const Color(0x00000000),
        elevation: 0,
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          child: Material(
            color: Colors.transparent,
            child: Ink(
              width: 40,
              height: 40,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Center(
                  child: Icon(
                    CupertinoIcons.arrow_left_circle,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        title: Text(
          '${widget.author.firstName} ${widget.author.lastName}',
          style: CCAppTheme.txtReg
              .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Divider(
                color: Colors.black,
              ),
              _getProfileRow(),
              Container(
                width: screenData.width - 32,
                height: 250,
                decoration: CCAppTheme.shadowDec,
                child: _getStatistics(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getStatistics() {
    final duration = DataFormatter.formattedDuration(
        Duration(seconds: widget.author.duration.toInt()),
        shouldNewLine: true);
    final loved = DataFormatter.getFormatted(number: widget.author.followers);
    final favorite =
        DataFormatter.getFormatted(number: widget.author.playCount);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        _getStatItemView(
          iconData: CupertinoIcons.person_circle_fill,
          text: 'Followers ',
          data: loved,
        ),
        _getStatItemView(
          iconData: CupertinoIcons.music_albums_fill,
          text: 'Tracks ',
          data: widget.author.trackIdList.length.toString(),
        ),
        _getStatItemView(
          iconData: CupertinoIcons.play_circle_fill,
          text: 'Played ',
          data: duration.replaceAll('\n', ' '),
        ),
        _getStatItemView(
          iconData: CupertinoIcons.heart_fill,
          text: 'Favorites ',
          data: favorite,
        ),
      ],
    );
  }

  Widget _getStatItemView(
      {required IconData iconData,
      required String text,
      required String data}) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Icon(
            iconData,
            color: CCAppTheme.periwinkleDarkColor,
          ),
        ),
        SizedBox(width: 120, child: Text(text)),
        Expanded(child: Text(data)),
      ],
    );
  }

  Widget _getProfileRow() {
    const profileWidth = 120.0;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius:
                const BorderRadius.all(Radius.circular(profileWidth / 2)),
            child: ProfileView(
              imagePath: widget.author.profilePicture,
              dimension: profileWidth,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: profileWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, right: 16),
                  child: Text(
                    widget.author.motivation.txt,
                    style: CCAppTheme.txtReg,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, right: 16),
                    child: Text(
                      widget.author.description.txt,
                      textAlign: TextAlign.justify,
                      style: CCAppTheme.txt.copyWith(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
