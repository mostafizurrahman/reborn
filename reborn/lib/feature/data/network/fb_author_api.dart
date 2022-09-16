

part of 'firebase_api.dart';


class FirebaseAuthorApi extends BaseApi {
  FirebaseAuthorApi() : super(BaseApi.author);

  @override
  Future<List<FBAuthorResponse>> getList() async {
    final List<FBAuthorResponse> data = await super._read<FBAuthorResponse>();
    return data;
  }
}