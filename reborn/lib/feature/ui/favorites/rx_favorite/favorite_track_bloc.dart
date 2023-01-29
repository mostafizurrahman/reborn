import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/feature/domain/firebase/usecase/get_favorite_use_case.dart';
import 'package:reborn/feature/firebase/firebase_handler.dart';
import 'package:reborn/utility/cache_storage.dart';
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
    final authors = cacheStorage.rebornAuthors;
    final favoriteUseCase = GetFavoriteTracksUseCase(authors: authors);
    final idList = firebase.favoriteTracks;
    final favorites = await favoriteUseCase(idList);
    emit(GetFavoriteTracksState(tracks: favorites));
  }
}
