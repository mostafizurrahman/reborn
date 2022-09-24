import 'package:flutter/material.dart';
import 'package:reborn/feature/base_widget/base_scaffold_state.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/widget/blur_round_view.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/screen_data.dart';
import 'dart:ui' as ui;
import '../widget/view_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenData.width,
      height: screenData.height,
      decoration: rebornTheme.decoration,
      child:SafeArea(
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          floatingActionButton: ViewProvider.backButton(context),
          backgroundColor: Colors.transparent,
          body: Container(
            width: screenData.width,


          ),
          bottomNavigationBar: AudioPlayerBottomView(track: widget.track),
        ),
      ),
    ) ;




      BaseScaffoldState(
      body: Container(
        width: screenData.width,
        height: screenData.height,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 64 + screenData.top, bottom: 8, left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ViewProvider.getCupertinoIcon(
                    iconValue: widget.track.trackIconData.toInt(),
                    color: Colors.pinkAccent,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    widget.track.trackTitle.en,
                    style: CCAppTheme.txtHL1,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 24),
              child: Text(
                widget.track.story.en,
                style:
                    CCAppTheme.txtReg.copyWith(color: Colors.black54, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(child: SizedBox(), flex: 1),
            Expanded(
              flex: 2,
              child: Center(
                child: AudioPlayerView(
                  track: widget.track,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(child: Slider(value: durationInMilSec, onChanged: onChanged)),
              ],
            ),
          ],
        ),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     Container(
        //       height: 120,
        //       color: Colors.redAccent,
        //       child: BackdropFilter(
        //         filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        //         child: SizedBox(
        //           height: 120,
        //           width: screenData.width,
        //           child: AudioPlayerView(track: widget.track,),
        //         ),
        //       ),
        //     ),
        //     SizedBox(height: 499, child: Center(
        //       child: Text("wh?"),
        //     ),),
        //
        //   ],
        // ),
      ),
    );
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider<RebornFilterBloc>.value(value: _rebornNameBloc),
    //     BlocProvider<FirebaseDataBloc>.value(value: _firebaseBloc),
    //   ],
    //   child: BaseScaffoldState(
    //     floating: BottomNavigationView(tabBarBehaviour: _tabBehaviour),
    //     floatLocation: FloatingActionButtonLocation.centerDocked,
    //     drawer: const MenuWidget(),
    //     body: SafeArea(
    //       child: SizedBox(
    //         height: screenData.height,
    //         child: StreamBuilder<List<TabBarData>>(
    //           stream: _tabBehaviour.stream,
    //           builder: _onBuildTabView,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  double durationInMilSec = 0;

  void onChanged(final double value) {
    durationInMilSec = value;
  }
}
