import 'package:reborn/feature/data/models/firebase/fb_track_response.dart';
import 'package:reborn/feature/data_model/base/base_state.dart';
import 'package:reborn/feature/domain/entities.dart';

abstract class FavoriteTrackState extends CCBaseState {}
class FavoriteTrackLoadingState extends FavoriteTrackState {}

class GetFavoriteTracksState extends FavoriteTrackState {
  final List<TrackEntity> tracks;
  GetFavoriteTracksState({required this.tracks});
}

abstract class ErrorFavoriteTrackState extends FavoriteTrackState {
  final String? error;
  ErrorFavoriteTrackState({this.error});
}

class SetFavoriteTrackState extends ErrorFavoriteTrackState {
  SetFavoriteTrackState({String? error}) : super(error: error);
}

class UnsetFavoriteTrackState extends ErrorFavoriteTrackState {
  UnsetFavoriteTrackState({String? error}) : super(error: error);
}

class RemoveFavoriteTrackState extends ErrorFavoriteTrackState {
  RemoveFavoriteTrackState({String? error}) : super(error: error);
}
