

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:reborn/feature/data_model/base/base_state.dart';
import 'package:reborn/feature/domain/entities.dart';

class SubscriptionState extends CCBaseState {

}

class SubscriptionLoadingState extends SubscriptionState {

}

class ProductLoadingState extends SubscriptionState {

}

class SubscriptionDataState extends SubscriptionState {
  final RebornSubscription subscription;
  SubscriptionDataState({required this.subscription});
}

class SubscribeProductState extends SubscriptionState {
  final ProductDetailsResponse product;
  SubscribeProductState({required this.product});
}

class RestoreSubscriptionState extends SubscriptionState {

}