import 'package:reborn/feature/data_model/base/base_state.dart';
import 'package:reborn/feature/domain/entities.dart';

class SubscriptionState extends CCBaseState {

}

class SubscriptionLoadingState extends SubscriptionState {

}


class SubscriptionDataState extends SubscriptionState {
  final RebornSubscription subscription;
  SubscriptionDataState({required this.subscription});
}

class SubscribePremiumContentState extends SubscriptionState {

}

class RestoreSubscriptionState extends SubscriptionState {

}