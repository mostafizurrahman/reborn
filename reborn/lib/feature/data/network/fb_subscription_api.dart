
part of 'firebase_api.dart';

class FirebaseSubscriptionApi extends BaseApi {
  FirebaseSubscriptionApi() : super(BaseApi.subscription);

  @override
  Future<List<FBCSubscriptionResponse>> getList() async {
    final List<FBCSubscriptionResponse> data = await super._read<FBCSubscriptionResponse>();
    return data;
  }
}
