import 'package:reborn/feature/data/models/firebase/fb_subscription_response.dart';
import 'package:reborn/feature/data/network/firebase_api.dart';
import 'package:reborn/feature/domain/base_use_case.dart';

import '../../entities.dart';

class GetSubscriptionUseCase implements BaseUseCase<RebornSubscription, int> {
  final FirebaseSubscriptionApi _subscriptionApi = FirebaseSubscriptionApi();
  @override
  Future<RebornSubscription> call(int _) async {
    final FBCSubscriptionResponse subscription =
        (await _subscriptionApi.getList()).first;
    return subscription.toEntity();
  }
}
