import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/feature/domain/firebase/entities/track_entity.dart';
import 'package:reborn/feature/firebase/firebase_handler.dart';
import 'package:reborn/feature/ui/audio_player/rx_audio/audio_player_bloc.dart';
import 'package:reborn/feature/ui/audio_player/rx_audio/audio_player_state.dart';
import 'package:reborn/feature/ui/widget/loader/loading_view.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/data_formatter.dart';
import 'package:reborn/utility/screen_data.dart';
import 'package:reborn/utility/user_info.dart';
import 'package:rxdart/rxdart.dart';
import '../rx_audio/audio_player_event.dart';
import 'progress_circle_painter.dart';

class AudioPlayerBottomView extends StatefulWidget {
  final TrackEntity track;
  final BehaviorSubject<PlayerInfoEntity> infoBehavior;
  const AudioPlayerBottomView({
    Key? key,
    required this.track,
    required this.infoBehavior,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AudioPlayerBottomState();
  }
}

class _AudioPlayerBottomState extends State<AudioPlayerBottomView> {
  static const int audioLength = 5000;
  int likeCount = 0;
  int duration = 0;
  double _sliderValue = 0;
  final BehaviorSubject<double> _sliderBehavior = BehaviorSubject.seeded(0);
  final BehaviorSubject<bool> _favoriteBehavior = BehaviorSubject();
  final PublishSubject<bool> _audioLoaderPublisher = PublishSubject();
  final AudioPlayerBloc _audioBloc = AudioPlayerBloc();
  static const double _playerDimension = 130;
  late final StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = _audioBloc.stream.listen(_onAudioBlocChanged);
    _audioBloc.add(LoadAudioEvent(trackEntity: widget.track));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _favoriteBehavior.sink
        .add(firebase.favoriteTracks.contains(widget.track.trackID));
  }

  void _onAudioBlocChanged(final AudioState audioState) {
    if (audioState is StartTrackAudioState) {
      _sliderValue = audioState.totalDuration;
      _audioLoaderPublisher.sink.add(true);
    } else if (audioState is FinishTrackAudioState) {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AudioPlayerBloc>.value(
      value: _audioBloc,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          height: 300,
          width: screenData.width - 48,
          decoration: CCAppTheme.shadowAudio,
          child: StreamBuilder(
            builder: _getAudioWidget,
            stream: _audioLoaderPublisher.stream,
          ),
        ),
      ),
    );
  }

  Widget _getAudioWidget(
      final BuildContext ctx, final AsyncSnapshot<bool> snap) {
    if (snap.data == true) {
      return Column(
        children: [
          _getAudioControlPanel(),
          _getAudioStatusPanel(),
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircularProgressIndicator(),
        SizedBox(
          height: 12,
        ),
        Text('Loading Audio...')
      ],
    );
  }

  Widget _getAudioControlPanel() {
    const double size = _playerDimension - 16;
    return SizedBox(
      height: 175,
      child: Stack(
        children: [
          Center(
            child: StreamBuilder(
              builder: _getProgressPainter,
              stream: _sliderBehavior.stream,
            ),
          ),
          Center(
            child: Container(
              height: size,
              width: size,
              decoration: CCAppTheme.circleBorderDec
                  .copyWith(color: CCAppTheme.periwinkleLightColor),
            ),
          ),
          Center(
            child: BlocBuilder(builder: _onBuildControlPanel, bloc: _audioBloc),
          ),
        ],
      ),
    );
  }

  Widget _getProgressPainter(
      final BuildContext ctx, final AsyncSnapshot<double> data) {
    final double progress =
        (_sliderBehavior.valueOrNull ?? 0) / _sliderValue * 100;
    return CustomPaint(
      size: const Size(_playerDimension, _playerDimension),
      painter: ProgressCirclePainter(
        circleRadius: _playerDimension / 2,
        topSpacing: 0,
        progress: progress,
      ),
    );
  }

  Widget _onBuildControlPanel(final BuildContext ctx, final AudioState state) {
    if (state is InitAudioState) {
      return const Center(
        child: Text('Loading audio...'),
      );
    }
    final icon = _getPlayPauseIconFor(state: state);
    return Row(
      children: [
        const SizedBox(width: 24),
        _getTapWidget(_onBackwardAudio, Icons.fast_rewind),
        const Expanded(flex: 2, child: SizedBox()),
        _getTapWidget(_onPlayAudio, icon, dimension: 70),
        const Expanded(flex: 2, child: SizedBox()),
        _getTapWidget(_onForwardAudio, Icons.fast_forward),
        const SizedBox(width: 24),
      ],
    );
  }

  IconData _getPlayPauseIconFor({required final AudioState state}) {
    if (state is AudioPlayingState || state is AudioDurationState) {
      return Icons.pause_circle_filled_rounded;
    }
    return Icons.play_arrow;
  }

  Widget _getAudioStatusPanel() {
    final duration = DataFormatter.formattedDuration(
      Duration(milliseconds: _sliderValue.toInt()),
    );
    return SizedBox(
      height: 125,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                duration,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 19,
                ),
              ),
              StreamBuilder<bool>(
                builder: _getFavoriteButton,
                stream: _favoriteBehavior.stream,
              ),
              BlocBuilder(
                builder: _getBlocBuilder,
                bloc: _audioBloc,
              ),
            ],
          ),
          StreamBuilder(
            builder: _getAudioSliderView,
            stream: _sliderBehavior.stream,
          ),
        ],
      ),
    );
  }

  Widget _getBlocBuilder(final BuildContext ctx, AudioState state) {
    return StreamBuilder(
      builder: _getDurationView,
      stream: _sliderBehavior.stream,
    );
  }

  Widget _getFavoriteButton(
      final BuildContext ctx, final AsyncSnapshot<bool> data) {
    final isFavorite = data.hasData && (data.data ?? false);
    final iconData =
        isFavorite ? CupertinoIcons.heart_fill : Icons.favorite_border;
    final color = isFavorite ? Colors.pinkAccent : Colors.black;
    return _getTapWidget(
      _onSetFavorite,
      iconData,
      color: color,
    );
  }

  void _onSetFavorite() async {
    startLoading(context);
    if (likeCount == 0) {
      likeCount = 1;
    } else {
      likeCount = 0;
    }
    firebase
        .setFavorite(trackEntity: widget.track, deviceID: userInfo.deviceID)
        .then((value) {
      _favoriteBehavior.sink.add(value);
      stopLoading(context);
    }).catchError((_) {
      stopLoading(context);
    });
  }

  Widget _getDurationView(
      BuildContext ctx, final AsyncSnapshot<double> snapshot) {
    late String duration;
    final state = _audioBloc.state;
    if (state is AudioDurationState) {
      duration = DataFormatter.formattedDuration(
        Duration(seconds: state.duration.inSeconds),
      );
      _sliderBehavior.sink.add(state.duration.inMilliseconds.toDouble());
    } else {
      final time = snapshot.data?.toInt() ?? widget.track.trackDuration * 1000;
      duration = DataFormatter.formattedDuration(
        Duration(milliseconds: time),
      );
    }
    return Text(
      duration,
      style: const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 19,
        fontFeatures: [FontFeature.tabularFigures()],
      ),
    );
  }

  Widget _getAudioSliderView(
      BuildContext ctx, final AsyncSnapshot<double> snapshot) {
    double value = snapshot.data ?? 0.0;
    if (value < 0) {
      value = 0;
    } else if (value >= _sliderValue) {
      value = _sliderValue;
    }
    return Slider(
      min: 0,
      max: _sliderValue,
      onChangeStart: _onChangeStared,
      onChangeEnd: _onChangeEnded,
      value: value,
      onChanged: _sliderBehavior.sink.add,
      inactiveColor: Colors.blueGrey,
      thumbColor: Colors.white,
      activeColor: CCAppTheme.pinkDarkerColor,
    );
  }

  void _onChangeStared(final double value) {
    _audioBloc.add(PlayPauseAudioEvent());
    _sliderBehavior.sink.add(value);
  }

  void _onChangeEnded(final double value) {
    _audioBloc.add(SeekAudioEvent(milliseconds: value.toInt()));
    _sliderBehavior.sink.add(value);
  }

  Widget _getTapWidget(final Function onTap, final IconData iconData,
      {final double dimension = 55.0,
      final Color color = const Color(0xFF7827E6)}) {
    return ClipRRect(
      borderRadius: CCAppTheme.brCircle,
      child: Material(
        child: Ink(
          decoration: CCAppTheme.circleBorderDec,
          width: dimension,
          height: dimension,
          child: InkWell(
            focusColor: Colors.blueAccent,
            splashColor: Colors.pinkAccent,
            onTap: () => onTap(),
            child: Center(
              child: Icon(
                iconData,
                size: dimension * 0.6,
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///TODO Audio events
  void _onBackwardAudio() {
    _audioBloc.add(ForwardAudioEvent(milliseconds: -audioLength));
  }

  void _onForwardAudio() {
    _audioBloc.add(ForwardAudioEvent(milliseconds: audioLength));
  }

  void _onPlayAudio() {
    _audioBloc.add(PlayPauseAudioEvent());
  }

  @override
  void dispose() {
    _subscription.cancel();
    _audioBloc.add(DisposeAudioEvent());
    _audioBloc.close();
    _updatePlayerInfo();
    super.dispose();
  }

  void _updatePlayerInfo() {
    duration = _sliderBehavior.value.toInt() ~/ 1000;
    if (likeCount == 1 || duration > 0) {
      final PlayerInfoEntity infoEntity =
          PlayerInfoEntity(likeCount: likeCount, totalPlayed: duration);
      widget.infoBehavior.sink.add(infoEntity);
    }
  }
}
