
part of 'firebase_api.dart';

class FirebaseConfigApi extends BaseApi {
  FirebaseConfigApi() : super(BaseApi.config);

  @override
  Future<List<FBConfigResponse>> getList() async {
    final List<FBConfigResponse> data = await super._read<FBConfigResponse>();
    return data;
  }
}

