

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:reborn/feature/domain/firebase/usecase/get_products_usecase.dart';
import 'package:reborn/feature/ui/subscription/rx_susbscription/subscription_states.dart';
import 'package:reborn/feature/ui/subscription/rx_susbscription/subscription_events.dart';
import 'package:reborn/feature/ui/subscription/subscription_constant.dart';

import '../../../domain/firebase/usecase/get_subscription_use_case.dart';




class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  SubscriptionBloc() : super(SubscriptionLoadingState()) {
    on<GetSubscriptionDataEvent>(_getSubscriptionData);
    on<SubscribeProductEvent>(_getSubscriptionProduct);
  }

  Future<void> _getSubscriptionData(final GetSubscriptionDataEvent event,
      final Emitter<SubscriptionState> emit) async {
    await Firebase.initializeApp();
    emit(SubscriptionLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    final useCase = GetSubscriptionUseCase();
    final entity = await useCase(0);
    emit(SubscriptionDataState(subscription: entity));
  }

  Future<void> _getSubscriptionProduct(final SubscribeProductEvent event,
      final Emitter<SubscriptionState> emit) async {

  }
}

class SubscriptionCubit extends Cubit<SubscriptionState> {
  SubscriptionCubit() : super(ProductLoadingState());
  void emitProductDetails() async {
    final InAppPurchase inAppPurchase = InAppPurchase.instance;
    final List<String> productsID = [SubscriptionConstant.playSubscriptionID];
    emit(ProductLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    final useCase = GetProductUseCase(inAppPurchase: inAppPurchase);
    final entity = await useCase(productsID);
    emit(SubscribeProductState(product: entity));
  }
}