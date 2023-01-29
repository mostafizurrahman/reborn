import 'package:reborn/feature/data_model/base/base_event.dart';
import 'package:reborn/feature/domain/entities.dart';

class FavoriteTrackEvent extends CCBaseEvent {

}


class GetFavoriteTracksEvent extends FavoriteTrackEvent {
  GetFavoriteTracksEvent();
}

class SetFavoriteTrackEvent extends FavoriteTrackEvent {
  final TrackEntity track;
  SetFavoriteTrackEvent({required this.track});
}

class UnsetFavoriteTrackEvent extends FavoriteTrackEvent {
  final TrackEntity track;
  UnsetFavoriteTrackEvent({required this.track});
}

class RemoveFavoriteTrackEvent extends FavoriteTrackEvent {
  final TrackEntity track;
  RemoveFavoriteTrackEvent({required this.track});
}


