

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/feature/ui/subscription/rx_susbscription/subscriptio_states.dart';
import 'package:reborn/feature/ui/subscription/rx_susbscription/subscriptoin_events.dart';

import '../../../domain/firebase/usecase/get_subscription_use_case.dart';




class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  SubscriptionBloc() : super(SubscriptionLoadingState()) {
    on<GetSubscriptionDataEvent>(_getSubscriptionData);
  }


  Future<void> _getSubscriptionData(final GetSubscriptionDataEvent event,
      final Emitter<SubscriptionState> emit) async {
    emit(SubscriptionLoadingState());
    await Future.delayed(Duration(seconds: 3));
    final usecase = GetSubscriptionUseCase();
    final entity = await usecase(0);
    emit(SubscriptionDataState(subscription: entity));
  }
}