
// Image App
// name : mostafizur rahman
// mobile : +8801675876752
// Created by mostafizurrahman on 6/2/22



import '../../domain/entities.dart';
import 'package:reborn/feature/data_model/base/base_event.dart';

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

class LoopAudioEvent extends AudioEvent {

}

class PlayerAudioEvent extends AudioEvent {

}

class FinishTrackAudioEvent extends AudioEvent {

}


class FinishListAudioEvent extends AudioEvent {

  final bool isLooping;
  FinishListAudioEvent({required this.isLooping});
}


class FinishAlbumAudioEvent extends AudioEvent {

}