import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/feature/firebase/firebase_handler.dart';

import '../../domain/firebase/usecase/get_favorite_use_case.dart';
import 'favorite_track_events.dart';
import 'favorite_track_states.dart';

class FavoriteTrackBloc extends Bloc<FavoriteTrackEvent, FavoriteTrackState> {
  FavoriteTrackBloc() : super(FavoriteTrackLoadingState()) {
    on<SetFavoriteTrackEvent>((event, emit) => emit(SetFavoriteTrackState()));
    on<GetFavoriteTracksEvent>(_getFavoriteTracks);
  }

  Future<void> _getFavoriteTracks(
    final GetFavoriteTracksEvent event,
    final Emitter<FavoriteTrackState> emit,
  ) async {
    final favoriteUseCase = GetFavoriteTracksUseCase();
    final idList = firebase.favoriteTracks;
    final favorites = await favoriteUseCase(idList);
    emit(GetFavoriteTracksState(tracks: favorites));
  }
}
