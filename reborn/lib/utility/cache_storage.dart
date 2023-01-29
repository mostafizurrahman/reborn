


import 'package:reborn/feature/domain/entities.dart';
import 'package:collection/collection.dart';
import 'package:reborn/feature/firebase/firebase_handler.dart';

class CacheStorage {
  final List<TrackEntity> _tracks = [];
  set tracks(final List<TrackEntity> tracks) {
    _tracks.clear();
    _tracks.addAll(tracks);
  }
  final List<RebornAuthor> _authors = [];
  set authors(final List<RebornAuthor> author){
    _authors.clear();
    _authors.addAll(author);
  }

  List<RebornAuthor> get rebornAuthors => _authors;


  static final _storage = CacheStorage._internal();
  factory CacheStorage() {
    return _storage;
  }
  CacheStorage._internal();

  Future<List<TrackEntity>> getTracksFrom({required final List<String> tracks}) async {
    final List<TrackEntity> favorites = [];
    for(final String trackId in tracks) {
      final track = _tracks.firstWhereOrNull((track) => track.trackID == trackId);
      if (track != null) {
        final author = _authors.firstWhereOrNull((author) => author.authorID == track.authorID);
        track.trackAuthor = author;
        favorites.add(track);
        await firebase.updateLocalFavorite(track: track);
      }
    }
    return favorites;
  }
}

final CacheStorage cacheStorage = CacheStorage();