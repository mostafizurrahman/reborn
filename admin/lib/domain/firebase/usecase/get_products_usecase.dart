import 'package:in_app_purchase/in_app_purchase.dart';

import '../../base_use_case.dart';

class GetProductUseCase
    implements BaseUseCase<ProductDetailsResponse, List<String>> {
  final InAppPurchase inAppPurchase;
  GetProductUseCase({required this.inAppPurchase});
  // final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  // late StreamSubscription<List<PurchaseDetails>> _subscription;
  // List<String> _notFoundIds = <String>[];
  // List<ProductDetails> _products = <ProductDetails>[];
  // List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  // List<String> _consumables = <String>[];
  // bool _isAvailable = false;
  // bool _purchasePending = false;
  // bool _loading = true;
  // String? _queryProductError;

  Future<ProductDetailsResponse> _onError(error, stackTrace) {
    return Future.value(
      ProductDetailsResponse(
        notFoundIDs: [],
        productDetails: [],
      ),
    );
  }

  @override
  Future<ProductDetailsResponse> call(List<String> kProductIds) async {
    final ProductDetailsResponse productDetailResponse = await inAppPurchase
        .queryProductDetails(kProductIds.toSet())
        .onError(_onError);
    return productDetailResponse;
  }
}
