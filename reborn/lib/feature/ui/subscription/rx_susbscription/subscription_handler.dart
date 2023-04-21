import 'dart:async';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:reborn/feature/ui/subscription/rx_susbscription/subscription_bloc.dart';

enum RestorePurchaseType {
  completed,
  error,
  processing,
  none,
}

abstract class SubscriptionInterface {
  void showPendingUI();
  void handleError(final IAPError? error);
  void deliverProduct(final PurchaseDetails productDetails);
  void handleInvalidPurchase(final PurchaseDetails productDetails);
}

class SubscriptionHandler {
  final List<PurchaseDetails> _purchasedProductList = [];
  final _inAppPurchase = InAppPurchase.instance;
  RestorePurchaseType restoreType = RestorePurchaseType.none;
  late final StreamSubscription<List<PurchaseDetails>> _subscription;
  final List<ProductDetails> productDetails;
  final SubscriptionBloc subscriptionBloc;
  final SubscriptionInterface interface;
  SubscriptionHandler({
    required this.interface,
    required this.subscriptionBloc,
    required this.productDetails,
  });

  Future<void> loadSubscription() async {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen(
      _onGetPurchasedProduct,
      onDone: _onDonePurchase,
      onError: _onPurchaseError,
    );
  }

  Future<void> _onGetPurchasedProduct(
      final List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        interface.showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          interface.handleError(purchaseDetails.error);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          final bool isValidProduct = await _verifyPurchase(purchaseDetails);
          if (isValidProduct) {
            restoreType = RestorePurchaseType.completed;
            _deliverProduct(purchaseDetails);
          } else {
            restoreType = RestorePurchaseType.error;
            interface.handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  void _deliverProduct(final PurchaseDetails productDetails) {
    _purchasedProductList.add(productDetails);
    interface.deliverProduct(productDetails);
  }

  Future<bool> _verifyPurchase(final PurchaseDetails productDetails) async {
    return true;
  }

  void _onDonePurchase() {

    restoreType = RestorePurchaseType.completed;
  }

  void restorePurchase() {
    restoreType = RestorePurchaseType.processing;
    _inAppPurchase.restorePurchases();
  }

  Future<void> purchaseProductFrom(
      {required ProductDetails productDetails}) async {
    late final PurchaseParam purchaseParam;
    if (Platform.isAndroid) {
      // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
      // verify the latest status of you your subscription by using server side receipt validation
      // and update the UI accordingly. The subscription purchase status shown
      // inside the app may not be accurate.
      GooglePlayPurchaseDetails? oldSubscription =
          _getOldSubscription(productDetails);
      ChangeSubscriptionParam? changeParam;
      if (oldSubscription != null) {
        changeParam = ChangeSubscriptionParam(
          oldPurchaseDetails: oldSubscription,
          prorationMode: ProrationMode.immediateWithTimeProration,
        );
      }
      purchaseParam = GooglePlayPurchaseParam(
        productDetails: productDetails,
        changeSubscriptionParam: changeParam,
      );
    } else if (Platform.isIOS) {
      purchaseParam = PurchaseParam(
        productDetails: productDetails,
      );
    } else {
      throw PlatformException(
        code: '1211',
        message: 'Invalid platform for in-app purchase!',
      );
    }
    _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  GooglePlayPurchaseDetails? _getOldSubscription(
    ProductDetails productDetails,
  ) {
    // This is just to demonstrate a subscription upgrade or downgrade.
    // This method assumes that you have only 2 subscriptions under a group, 'subscription_silver' & 'subscription_gold'.
    // The 'subscription_silver' subscription can be upgraded to 'subscription_gold' and
    // the 'subscription_gold' subscription can be downgraded to 'subscription_silver'.
    // Please remember to replace the logic of finding the old subscription Id as per your app.
    // The old subscription is only required on Android since Apple handles this internally
    // by using the subscription group feature in iTunesConnect.
    GooglePlayPurchaseDetails? oldSubscription =
        _purchasedProductList.firstWhereOrNull(
                (product) => product.productID == productDetails.id)
            as GooglePlayPurchaseDetails?;
    return oldSubscription;
  }

  void _onPurchaseError(final Object error) {
    interface.handleError(null);
  }

  void dispose() {
    _subscription.cancel();
  }
}
