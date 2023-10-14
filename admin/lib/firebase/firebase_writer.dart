part of "firebase_handler.dart";

class _FirebaseWriter {
  final _sqlWriter = const _SQLWriter();
  final FirebaseFirestore _firebaseStore;
  const _FirebaseWriter(this._firebaseStore);

  Future<bool> _setFavoriteTrack(final TrackEntity entity,
      {required final String deviceID,
      required final List<String> favoriteList}) async {
    final String trackId = entity.trackID;
    bool isSuccess;
    bool isContains = favoriteList.contains(trackId);
    if (isContains) {
      favoriteList.remove(trackId);
    } else {
      favoriteList.add(trackId);
    }
    final favorites = {'favorite_tracks': favoriteList};
    await _firebaseStore
        .collection(BaseApi.users)
        .doc(deviceID)
        .collection('favorites')
        .doc('tracks')
        .set(favorites);
    isSuccess = isContains
        ? await _removeFavoriteTrack(entity)
        : await _updateLocalFavoriteTrack(entity);
    return Future.value(isSuccess && !isContains);
  }

  Future<bool> _updateLocalFavoriteTrack(final TrackEntity entity) async {
    final isSuccess = await _sqlWriter._setFavoriteTrack(entity);
    return Future.value(isSuccess);
  }

  Future<bool> _removeFavoriteTrack(final TrackEntity entity) async {
    final isSuccess = await _sqlWriter._removeFavoriteTrack(entity);
    return Future.value(isSuccess);
  }
}

class _SQLWriter {
  const _SQLWriter();
  Future<bool> _setFavoriteTrack(final TrackEntity entity) async {
    final trackData = entity.toJson();
    final isSuccess = await sqlDatabase.saveFavorite(trackData, entity.trackID);
    return Future.value(isSuccess);
  }

  Future<bool> _removeFavoriteTrack(final TrackEntity entity) async {
    final isSuccess = await sqlDatabase.deleteFavorite(entity.trackID);
    return Future.value(isSuccess);
  }
}
