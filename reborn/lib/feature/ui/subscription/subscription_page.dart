import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase_platform_interface/src/errors/in_app_purchase_error.dart';
import 'package:in_app_purchase_platform_interface/src/types/purchase_details.dart';
import 'package:reborn/feature/data_model/static_data.dart';
import 'package:reborn/feature/ui/home/home_widget.dart';
import 'package:reborn/feature/ui/subscription/rx_susbscription/subscription_handler.dart';
import 'package:reborn/feature/ui/subscription/rx_susbscription/subscription_states.dart';
import 'package:reborn/feature/ui/subscription/rx_susbscription/subscription_bloc.dart';
import 'package:reborn/feature/ui/subscription/rx_susbscription/subscription_events.dart';
import 'package:reborn/utility/screen_data.dart';
import 'package:reborn/utility/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities.dart';
import '../dialogs/bottom_dialog_widget.dart';
import '../widget/loader/loading_view.dart';
import 'widget/status_card.dart';
import 'widget/status_content_view.dart';
import 'widget/subscription_moto_view.dart';
import 'widget/subscription_top_bar.dart';
import 'widget/subscription_view.dart';
import 'widget/trial_title_view.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SubscriptionPageState();
  }
}

class _SubscriptionPageState extends State<SubscriptionPage>
    implements
        SubscriptionInterface,
        SubscriptionTapHandler,
        DialogTapInterface {
  final subscriber = SubscriptionBloc();
  final product = SubscriptionCubit();
  SubscriptionHandler? subscriptionHandler;
  late final StreamSubscription subscription;
  int productIndex = 0;
  @override
  void initState() {
    super.initState();
    subscriber.add(GetSubscriptionDataEvent());
    subscription = product.stream.listen(_onProductStatus);
  }

  void _onProductStatus(SubscriptionState state) {
    if (state is SubscribeProductState) {
      subscriptionHandler = SubscriptionHandler(
        subscriptionBloc: subscriber,
        productDetails: state.product.productDetails,
        interface: this,
      );
      subscriptionHandler?.loadSubscription();
    }
  }

  @override
  Widget build(BuildContext context) {
    screenData.setScreenData(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder(
        bloc: subscriber,
        builder: _getSubscriptionContent,
      ),
    );
  }

  Widget _getSubscriptionContent(
      final BuildContext ctx, final SubscriptionState state) {
    if (state is SubscriptionLoadingState) {
      return defaultLoader;
    }
    if (state is SubscriptionDataState) {
      return _getSubscriptionBody(state.subscription);
    }
    return const SizedBox();
  }

  Widget _getSubscriptionBody(final RebornSubscription subscription) {
    product.emitProductDetails();
    final items = StaticData.getStatusItemList();
    final cancelTitle = LocalizedText(
      en: 'No commitments, cancel anytime',
      ru: 'Никаких обязательств, отменить в любое время',
    );
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const SubscriptionTopBar(),
              SizedBox(height: 24),
              TrialTitleView(),
              StatusContentView(
                verticleItems: items,
                index: 2,
              ),
              SizedBox(height: 12),
              Divider(height: 2),
              Padding(
                padding: EdgeInsets.all(12),
                child: SubscriptionView(
                  subscriptionCubit: product,
                  tapHandler: this,
                ),
              ),
              Divider(height: 2),
              SubscriptionMotoView(moto: subscription.moto),
              StatusCard(subscription: subscription),
              SizedBox(height: 12),
              Text(cancelTitle.txt),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'After free trial, Reborn yearly subscription is \$59.99 and automatically renews unless auto-renew is turned off at least 24h before current period ends. Payment is charged to your iTunes account.',
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              ),
              SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void deliverProduct(PurchaseDetails productDetails) {
    // TODO: implement deliverProduct
    userInfo.isSubscribed = true;

  }

  @override
  void handleError(IAPError? error) {
    // TODO: implement handleError

    _showBottomSheet(_getErrorDialogBody);
  }

  @override
  void handleInvalidPurchase(PurchaseDetails productDetails) {
    // TODO: implement handleInvalidPurchase
    _showBottomSheet(_getInvalidPurchaseDialogBody);
  }

  @override
  void showPendingUI() {
    // TODO: implement showPendingUI
  }

  ///TODO : Subscription tap handler

  @override
  void onForgetToCancel() {
    // TODO: implement onForgetToCancel
  }

  @override
  void onTapRestoreSubscription() {
    // TODO: implement onTapRestoreSubscription
    subscriptionHandler?.restorePurchase();
  }

  @override
  void onTapSubscription() {
    // TODO: implement onTapSubscription
    final state = product.state;
    if (state is SubscribeProductState) {
      final product = state.product.productDetails.first;
      subscriptionHandler?.purchaseProductFrom(productDetails: product);
    }
  }

  Widget _getErrorDialogBody(_) {
    final content = DialogContent(
      title: const LocalizedText(
        en: 'Something went wrong',
        ru: 'Something went wrong',
      ),
      description: const LocalizedText(
        en: 'We can not complete the subscription process right now! Please try again later.',
        ru: 'Мы не можем завершить процесс подписки прямо сейчас! Пожалуйста, повторите попытку позже.',
      ),
    );
    return BottomDialogWidget(content: content, tapInterface: this);
  }

  Widget _getInvalidPurchaseDialogBody(_) {
    final content = DialogContent(
      title: const LocalizedText(
        en: 'Invalid Purchase',
        ru: 'Недействительная покупка',
      ),
      description: const LocalizedText(
        en: 'We are unable to complete your purchase request. Something went wrong, please try again later!',
        ru: 'Если можете, заполните заявку на покупку. Вместо этого что-то погнулось, повторите попытку позже!',
      ),
    );
    return BottomDialogWidget(content: content, tapInterface: this);
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  void onOtherOptionTapped() {
    // TODO: implement onOtherOptionTapped
    Navigator.pop(context);

  }

  void _goToHome() {
    isDialogOpened = false;
    userInfo.isSubscribed = true;
    SharedPreferences.getInstance().then((value) {
      value.setBool( 'subscribed', true).then((value) => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const HomeWidget()),
              (route) => false
      ));
    });
  }

  @override
  void onTapClose() {
    // TODO: implement onTapClose title_view cross button
    debugPrint('I am title cross tap');
    isDialogOpened = false;
    Navigator.pop(context);
    _goToHome();
  }

  @override
  void onTapNo() {
    // TODO: implement onTapNo
  }

  @override
  void onTapYes() {
    // TODO: implement onTapYes
  }

  @override
  void showEmptySubscription() {
    // TODO: implement showEmptySubscription
    _showBottomSheet(_getEmptyPurchaseDialogBody);
  }

  Widget _getEmptyPurchaseDialogBody(_) {
    final content = DialogContent(
      title: const LocalizedText(
        en: 'No Subscription',
        ru: 'Нет подписки',
      ),
      description: const LocalizedText(
        en: 'You have subscription! Please subscribe to avail the exclusive meditation materials!',
        ru: 'У вас есть подписка! Пожалуйста, подпишитесь, чтобы получить доступ к эксклюзивным материалам для медитации!',
      ),
    );
    return BottomDialogWidget(content: content, tapInterface: this);
  }

  void _showBottomSheet(DialogBody dialogBody) {
    if (!isDialogOpened) {
      isDialogOpened = true;
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isDismissible: false,
        context: context,
        builder: dialogBody,
      );
    }
  }

  @override
  bool isDialogOpened = false;
}

typedef DialogBody = Widget Function(BuildContext);
