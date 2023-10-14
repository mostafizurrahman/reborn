
part of 'firebase_api.dart';


class FirebaseCategoryApi extends BaseApi {
  FirebaseCategoryApi() : super(BaseApi.category);

  @override
  Future<List<FBCategoryResponse>> getList() async {
    final List<FBCategoryResponse> data = await super._read<FBCategoryResponse>();
    return data;
  }
}