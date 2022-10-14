// Image App
// name : mostafizur rahman
// mobile : +8801675876752
// Created by mostafizurrahman on 6/2/22

import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';

import '../../domain/entities.dart';
import 'audio_player_event.dart';
import 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioEvent, AudioState> {
  int _trackIndex = 0;
  int _shuffleIndex = 0;
  bool _shouldLoop = false;
  bool _shouldShuffle = false;
  final List<TrackEntity> _trackList = [];
  final List<TrackEntity> _shuffleList = [];

  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();
  late final StreamSubscription _audioPlayerFinished;

  AudioPlayerBloc() : super(InitAudioState()) {
    _audioPlayerFinished = _audioPlayer.playlistAudioFinished.listen(_onAudioPlayingFinished);
    on<TrackAudioEvent>(_onTrackAudioEvent);
    on<PlayerAudioEvent>(_onPlayerAudioEvent);
    on<LoadAudioEvent>(_onLoadAudioEvent);
    on<ShuffleAudioEvent>(_onShuffleAudioEvent);
    on<LoopAudioEvent>(_onLoopAudioEvent);
    on<FinishAlbumAudioEvent>((event, emit) => emit(FinishAlbumAudioState()));
    on<FinishTrackAudioEvent>((event, emit) => emit(FinishTrackAudioState()));
    on<FinishListAudioEvent>(
        (event, emit) => emit(FinishListAudioState(isLooping: event.isLooping)));
  }

  void _onAudioPlayingFinished(final Playing playing) {
    add(FinishTrackAudioEvent());
    int _index = _nextAudioIndex;
    if (_shouldLoop) {
      if (_index == 0) {
        add(FinishListAudioEvent(isLooping: true));
        final _track = _shouldShuffle ? _shuffleList[_index] : _trackList[_index];
        add(LoadAudioEvent(trackEntity: _track));
      }
    } else if (_index == 0) {
      add(FinishListAudioEvent(isLooping: false));
    } else {
      final _track = _shouldShuffle ? _shuffleList[_index] : _trackList[_index];
      add(LoadAudioEvent(trackEntity: _track));
    }
  }

  Future<void> _onLoopAudioEvent(final LoopAudioEvent event, final Emitter<AudioState> emit) async {
    emit(InitAudioState());
    _shouldLoop = !_shouldLoop;
    final _loopState = LoopAudioState(isLooped: _shouldLoop);
    emit(_loopState);
  }

  Future<void> _onShuffleAudioEvent(
      final ShuffleAudioEvent event, final Emitter<AudioState> emit) async {
    emit(InitAudioState());
    _setShuffleTracks();
    final _shuffleState = ShuffleAudioState(isShuffled: _shouldShuffle);
    emit(_shuffleState);
  }

  Future<void> _onLoadAudioEvent(final LoadAudioEvent event, final Emitter<AudioState> emit) async {
    emit(InitAudioState());
    final audio = event.trackEntity.isLocalTrack
        ? Audio(event.trackEntity.trackAudio)
        : Audio.network(event.trackEntity.trackAudio);
    _audioPlayer.open(audio, showNotification: true).onError((error, stackTrace) {
      final errorState = ErrorAudioState(
        errorMessage: "unable to open audio file",
        error: error,
        stackTrace: stackTrace,
      );
      emit(errorState);
    }).then(
      (value) => emit(StartTrackAudioState(trackEntity: event.trackEntity)),
    );
  }

  Future<void> _onPlayerAudioEvent(
      final PlayerAudioEvent event, final Emitter<AudioState> emit) async {
    final bool isPlaying = _audioPlayer.isPlaying.value;
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
    emit(PlayerAudioState(isPlaying: !isPlaying));
  }

  Future<void> _onTrackAudioEvent(
      final TrackAudioEvent event, final Emitter<AudioState> emit) async {
    _trackIndex = event.trackIndex;
    _trackList.clear();
    _trackList.addAll(event.trackList);
    final _track = _trackList[_trackIndex];
    add(LoadAudioEvent(trackEntity: _track));
  }

  @override
  Future<void> close() {
    _audioPlayerFinished.cancel();
    return super.close();
  }

  //TODO - AUDIO METHODS
  int get _nextAudioIndex {
    if (_shouldShuffle) {
      _shuffleIndex++;
      if (_shuffleIndex >= _shuffleList.length) {
        _shuffleIndex = 0;
      }
      return _shuffleIndex;
    } else {
      _trackIndex++;
      if (_trackIndex >= _trackList.length) {
        _trackIndex = 0;
      }
      return _trackIndex;
    }
  }

  void _setShuffleTracks() {
    _shouldShuffle = !_shouldShuffle;
    if (_shouldShuffle) {
      _shuffleIndex = 0;
      _shuffleList.clear();
      _shuffleList.addAll(_trackList);
      _shuffleList.shuffle();
      //TODO - Remove playing audio and insert it at the first position
      if (_audioPlayer.isPlaying.value) {
        final _assetPath = _audioPlayer.current.value?.audio.assetAudioPath;
        final _track = _trackList.firstWhere((element) => element.trackAudio == _assetPath);
        _shuffleList.remove(_track);
        _shuffleList.insert(0, _track);
        _trackIndex = 0;
      }
    }
  }
}
