
// Image App
// name : mostafizur rahman
// mobile : +8801675876752
// Created by mostafizurrahman on 6/2/22



import 'package:reborn/feature/data_model/base/base_state.dart';
import 'package:reborn/feature/domain/firebase/entities/track_entity.dart';

abstract class AudioState extends CCBaseState{

}

class InitAudioState extends AudioState {

}

class ErrorAudioState extends AudioState {
  final Object? error;
  final StackTrace? stackTrace;
  final String errorMessage;
  ErrorAudioState({required this.errorMessage, this.error, this.stackTrace});
}

class TrackAudioState extends AudioState {
  TrackAudioState();
}

class AlbumAudioState extends AudioState {
  AlbumAudioState();
}

class LoadAudioState extends AudioState {
  final TrackEntity trackEntity;
  LoadAudioState({required this.trackEntity});
}

class ShuffleAudioState extends AudioState {
  final bool isShuffled;
  ShuffleAudioState({required this.isShuffled});
}

class LoopAudioState extends AudioState {
  final bool isLooped;
  LoopAudioState({required this.isLooped});
}

class StartTrackAudioState extends AudioState {
  final TrackEntity trackEntity;
  final double totalDuration;
  StartTrackAudioState({required this.trackEntity, required this.totalDuration,});
}


class FinishTrackAudioState extends AudioState {

}

class DisposeAudioState extends AudioState {

}

class AudioDurationState extends AudioState {
  final Duration duration;
  AudioDurationState({required this.duration});
}

class FinishListAudioState extends AudioState {
    final bool isLooping;
    FinishListAudioState({required this.isLooping});
}


class FinishAlbumAudioState extends AudioState {

}

class AudioPlayingState extends AudioState {
  AudioPlayingState();
}


class AudioPausedState extends AudioState {
  AudioPausedState();
}