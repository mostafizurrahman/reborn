
part of 'firebase_api.dart';

class FirebaseSleepApi extends BaseApi {
  FirebaseSleepApi() : super(BaseApi.sleep);

  @override
  Future<List<FBCategoryResponse>> getList() async {
    final List<FBCategoryResponse> data = await super._read<FBCategoryResponse>();
    return data;
  }
}
