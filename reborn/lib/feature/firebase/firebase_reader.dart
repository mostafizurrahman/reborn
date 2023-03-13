part of "firebase_handler.dart";

class _SQLReader {}

class _LocalStorageReader {}

class _FirebaseReader {
  final FirebaseFirestore _firebaseStore;
  const _FirebaseReader(this._firebaseStore);
  Future<List<T>> read<T extends BaseResponse>(
      {required String collectionKey}) async {
    final List<T> dataList = [];
    try {
      final collection = await _firebaseStore.collection(collectionKey).get();
      for (final element in collection.docs) {
        final data = element.data();
        data['documentId'] = element.id;
        dataList.add(_getConcreteResponse(data, collectionKey) as T);
      }
    } on FirebaseException catch (e) {
      // Caught an exception from Firebase.
      final BaseResponse error = FBErrorResponse(
          code: e.code, message: e.message ?? "firebase read fail");
      dataList.add(error as T);
    }

    return dataList;
  }

  static BaseResponse _getConcreteResponse(
      final Map<String, dynamic> _data, final String key) {
    if (key == BaseApi.category) {
      return FBCategoryResponse.fromJson(_data);
    } else if (key == BaseApi.config) {
      return FBConfigResponse.fromJson(_data);
    } else if (key == BaseApi.users) {
      return FBUserResponse.fromJson(_data);
    } else if (key == BaseApi.author) {
      return FBAuthorResponse.fromJson(_data);
    } else if (key == BaseApi.tracks) {
      return FBTrackResponse.fromJson(_data);
    } else if (key == BaseApi.sleep) {
      return FBCategoryResponse.fromJson(_data);
    } else if (key == BaseApi.subscription) {
      return FBCategoryResponse.fromJson(_data);
    }
    throw FirebaseException(
      plugin: "plugin.firebase",
      code: "444",
      message: "concrete class not found",
    );
  }
}
