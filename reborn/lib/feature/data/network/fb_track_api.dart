
part of 'firebase_api.dart';

class FirebaseTrackApi extends BaseApi {
  FirebaseTrackApi() : super(BaseApi.tracks);

  @override
  Future<List<FBTrackResponse>> getList() async {
    final List<FBTrackResponse> data = await super._read<FBTrackResponse>();
    return data;
  }
}

