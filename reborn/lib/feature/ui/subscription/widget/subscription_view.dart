
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/ui/subscription/rx_susbscription/subscription_states.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/screen_data.dart';

import '../rx_susbscription/subscription_bloc.dart';


abstract class SubscriptionTapHandler {
  void onTapSubscription();
  void onTapRestoreSubscription();
  void onForgetToCancel();
}


class SubscriptionView extends StatelessWidget {
  final SubscriptionTapHandler tapHandler;
  final SubscriptionCubit subscriptionCubit;
  static const String due = '0.00\$';
  const SubscriptionView({
    Key? key,
    required this.subscriptionCubit,
    required this.tapHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const totalDue = LocalizedText(
        en: 'Total due today : $due', ru: 'Total due today: $due');
    const instruction = LocalizedText(
      en: 'You won\'t be charged until after your free trial.',
      ru: 'You won\'t be charged until after your free trial.',
    );
    const forget = LocalizedText(
      en: 'Restore Subscription',
      ru: 'Восстановить подписку',
    );
    return Material(
      color: Colors.transparent,
      shadowColor: Colors.greenAccent,
      borderRadius: BorderRadius.all(Radius.circular(8)),
      child: Column(
        children: [
          Text(totalDue.txt),
          Text(instruction.txt),
          SizedBox(height: 36),
          _getSubscriptionButton(context),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Ink(
              decoration: CCAppTheme.shadowNoBorder,
              child: InkWell(
                onTap: tapHandler.onTapRestoreSubscription,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(forget.txt),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getSubscriptionButton(context) {

    return Material(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      // color: Colors.white,
      child: BlocBuilder(
        builder: _buildCubit,
        bloc: subscriptionCubit,
      ),
    );
  }

  Widget _buildCubit(final BuildContext context, final SubscriptionState state) {
    const trial = LocalizedText(
      en: 'Start Free Trial',
      ru: 'Начать бесплатную пробную версию',
    );

    return Container(
      width: screenData.width,
      decoration:
      CCAppTheme.subscriptionDecoration.copyWith(color: Colors.white),
      child: InkWell(
        splashColor: Colors.redAccent,
        hoverColor: Colors.redAccent,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        onTap: shouldTap ? tapHandler.onTapSubscription : null,
        // child: Text('done'),
        child: Column(
          children: [
            SizedBox(height: 24),
            Text(trial.txt, style: CCAppTheme.txt),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: _getProductCubit(state),
                  ),
                )
              ],
            ),
            SizedBox(height: 8),
            _getProductMonthCubit(state),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _getProductCubit(final SubscriptionState state) {
    String price = '--/--';
    if (state is SubscribeProductState) {
      final product = state.product.productDetails.first;
      price = product.price;
    }
    final priceTxt = LocalizedText(
      en: 'Try 7-days for free, then $price',
      ru: 'TПопробуйте 7 дней бесплатно, затем $price',
    );
    return Text(
      priceTxt.txt,
      textAlign: TextAlign.center,
      style: CCAppTheme.txt2,
    );
  }

  Widget _getProductMonthCubit(final SubscriptionState state) {
    String price = '--/--';
    if (state is SubscribeProductState) {
      final product = state.product.productDetails.first;
      price = product.price;
    }

    final monthPrice = LocalizedText(
      en: '(Only $price/mo)',
      ru: '(Только $price/mo)',
    );
    return Text(
      monthPrice.txt,
      textAlign: TextAlign.center,
      style: CCAppTheme.txtHL3,
    );
  }

  bool get shouldTap => subscriptionCubit.state is SubscribeProductState;
}
