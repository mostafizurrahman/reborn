
// Image App
// name : mostafizur rahman
// mobile : +8801675876752
// Created by mostafizurrahman on 6/2/22



import 'package:reborn/feature/data_model/base/base_event.dart';
import 'package:reborn/feature/domain/firebase/entities/track_entity.dart';

abstract class AudioEvent extends CCBaseEvent{

}

class TrackAudioEvent extends AudioEvent {
  final List<TrackEntity> trackList;
  final int trackIndex;
  TrackAudioEvent({required this.trackList, required this.trackIndex});
}

class LoadAudioEvent extends AudioEvent {
  final TrackEntity trackEntity;
  LoadAudioEvent({required this.trackEntity});
}

class ShuffleAudioEvent extends AudioEvent {
  ShuffleAudioEvent();
}

class SeekAudioEvent extends AudioEvent {
  final int milliseconds; // +seconds for froward & -seconds for backward
  SeekAudioEvent({required this.milliseconds});
}

class ForwardAudioEvent extends AudioEvent {
  final int milliseconds; // +seconds for froward & -seconds for backward
  ForwardAudioEvent({required this.milliseconds});
}


class LoopAudioEvent extends AudioEvent {

}



class PlayPauseAudioEvent extends AudioEvent {

}

class FinishTrackAudioEvent extends AudioEvent {

}
class EmitAudioDurationEvent extends AudioEvent {
  final Duration duration;
  EmitAudioDurationEvent({required this.duration});
}


class FinishListAudioEvent extends AudioEvent {

  final bool isLooping;
  FinishListAudioEvent({required this.isLooping});
}


class FinishAlbumAudioEvent extends AudioEvent {

}

class DisposeAudioEvent extends AudioEvent {

}