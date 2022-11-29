import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/feature/audio_player/rx_audio/audio_player_bloc.dart';
import 'package:reborn/feature/audio_player/rx_audio/audio_player_state.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/data_formatter.dart';
import 'package:reborn/utility/screen_data.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities.dart';
import '../rx_audio/audio_player_event.dart';

class AudioPlayerBottomView extends StatefulWidget {
  final TrackEntity track;
  const AudioPlayerBottomView({
    Key? key,
    required this.track,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AudioPlayerBottomState();
  }
}

class _AudioPlayerBottomState extends State<AudioPlayerBottomView> {
  static const int audioLength = 5;
  final BehaviorSubject<double> _sliderBehavior = BehaviorSubject();
  final AudioPlayerBloc _audioBloc = AudioPlayerBloc();
  double sliderValue = 0;

  @override
  void initState() {
    super.initState();
    _audioBloc.add(LoadAudioEvent(trackEntity: widget.track));
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
          decoration: CCAppTheme
              .shadowAudio, //.copyWith(borderRadius: rebornTheme.topRound),
          child: Column(
            children: [
              _getAudioControlPanel(),
              _getAudioStatusPanel(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getAudioControlPanel() {
    return SizedBox(
      height: 175,
      child: Stack(
        children: [
          Center(
            child: Container(
              height: 140,
              width: 140,
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
        const Expanded(child: SizedBox(), flex: 2),
        _getTapWidget(_onPlayAudio, icon, dimension: 70),
        const Expanded(child: SizedBox(), flex: 2),
        _getTapWidget(_onForwardAudio, Icons.fast_forward),
        const SizedBox(width: 24),
      ],
    );
  }

  IconData _getPlayPauseIconFor({required final AudioState state}) {
    if (state is AudioPlayingState) {
      return Icons.pause_circle_filled_rounded;
    }

    return Icons.play_arrow;
  }

  Widget _getAudioStatusPanel() {
    final duration = DataFormatter.formattedDuration(
      Duration(seconds: widget.track.trackDuration),
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
                  fontSize: 32,
                ),
              ),
              _getTapWidget(
                _onBackwardAudio,
                Icons.favorite_border,
                color: Colors.pinkAccent,
              ),
              StreamBuilder(
                builder: _getDurationView,
                stream: _sliderBehavior.stream,
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

  Widget _getDurationView(
      BuildContext ctx, final AsyncSnapshot<double> snapshot) {
    late String duration;
    final state = _audioBloc.state;
    if (state is AudioDurationState) {
      duration = DataFormatter.formattedDuration(
        Duration(seconds: state.duration.inSeconds),
      );
      debugPrint('duration ----------------- ${state.duration.inSeconds}');
      _sliderBehavior.sink.add(state.duration.inSeconds.toDouble());
    } else {
      duration = DataFormatter.formattedDuration(
        Duration(
            seconds: snapshot.data?.toInt() ?? widget.track.trackDuration),
      );
    }
    return Text(
      duration,
      style: const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 32,
      ),
    );
  }

  Widget _getAudioSliderView(
      BuildContext ctx, final AsyncSnapshot<double> snapshot) {
    return Slider(
      min: 0,
      max: 1,
      onChangeStart: _onChangeStared,
      onChangeEnd: _onChangeEnded,
      value: snapshot.data ?? 0,
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
    _audioBloc.add(SeekAudioEvent(seconds: value.toInt()));
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
    _audioBloc.add(ForwardAudioEvent(seconds: -audioLength));
  }

  void _onForwardAudio() {
    _audioBloc.add(ForwardAudioEvent(seconds: audioLength));
  }

  void _onPlayAudio() {
    _audioBloc.add(PlayPauseAudioEvent());
  }

  @override
  void dispose() {
    _audioBloc.close();
    super.dispose();
  }
}
