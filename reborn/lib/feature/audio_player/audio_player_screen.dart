import 'package:flutter/material.dart';
import 'package:reborn/feature/base_widget/base_scaffold_state.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/widget/blur_round_view.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/screen_data.dart';
import 'dart:ui' as ui;
import '../home/widgets/author_blur_view.dart';
import '../widget/view_provider.dart';
import 'rx_audio/audio_player_bloc.dart';
import 'widget/audio_player_bottom_view.dart';
import 'widget/audio_player_view.dart';

class AudioPlayerScreen extends StatefulWidget {
  final TrackEntity track;
  const AudioPlayerScreen({Key? key, required this.track}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _AudioPlayerState();
  }

  static const path = "/home/audio_player";
  static TrackEntity getTrack(final Map args) {
    final TrackEntity track = args["track"] as TrackEntity;
    return track;
  }
}

class _AudioPlayerState extends State<AudioPlayerScreen> {

  final AudioPlayerBloc _playerBloc = AudioPlayerBloc();


  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenData.width,
      height: screenData.height,
      decoration: rebornTheme.decoration,
      child: SafeArea(
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          floatingActionButton: ViewProvider.backButton(context),
          backgroundColor: Colors.transparent,
          body: Container(
            width: screenData.width,
            decoration: decoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 64 + screenData.top),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 24),
                    ViewProvider.getCupertinoIcon(
                      iconValue: widget.track.trackIconData.toInt(),
                      color: Colors.pinkAccent,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      widget.track.trackTitle.en,
                      style: CCAppTheme.txtHL1,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 8),
                  child: Text(
                    widget.track.story.en,
                    style: CCAppTheme.txtReg
                        .copyWith(color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                ),
                const Expanded(child: SizedBox()),
                const Padding(
                  padding: EdgeInsets.only(left: 24, bottom: 6),
                  child: Text("By--"),
                ),
                if (widget.track.trackAuthor != null)
                  AuthorLeftRoundView(authorData: widget.track.trackAuthor!),
              ],
            ),
          ),
          bottomNavigationBar: AudioPlayerBottomView(track: widget.track),
        ),
      ),
    );
  }

  BoxDecoration get decoration => BoxDecoration(
        // image: const DecorationImage(
        //   image: AssetImage('lib/assets/track_background.png'),
        //   fit: BoxFit.cover,
        // ),
        gradient: LinearGradient(
          colors: [Colors.white.withAlpha(150), CCAppTheme.periwinkleDarkColor.withAlpha(50)],
          begin: FractionalOffset(0.0, 0.30),
          end: FractionalOffset(0.0, 1.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      );

  double durationInMilSec = 0;

  void onChanged(final double value) {
    durationInMilSec = value;
  }


  @override
  void dispose() {
    _playerBloc.close();
    super.dispose();
  }
}
