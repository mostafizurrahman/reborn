
import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities.dart';
import '../../../domain/firebase/entities/reborn_subscription.dart';
import '../../network/firebase_api.dart';
import '../localized_response.dart';
part 'fb_subscription_response.g.dart';

@JsonSerializable(createToJson: false)
class FeedbackResponse extends BaseResponse {
  final String? id;
  final String? image;
  final LocalizedResponse? name;
  final LocalizedResponse? review;
  final LocalizedResponse? title;
  final String? stars;
  FeedbackResponse({
    required this.id,
    required this.image,
    required this.name,
    required this.review,
    required this.title,
    required this.stars,
  });

  factory FeedbackResponse.fromJson(Map<String, dynamic> json) =>
      _$FeedbackResponseFromJson(json);

  RebornFeedback toEntity() => RebornFeedback(
        id: id ?? '',
        name: name?.toEntity() ?? emptyTxt,
        title: title?.toEntity() ?? emptyTxt,
        stars: stars ?? '',
        image: image ?? '',
        review: review?.toEntity() ?? emptyTxt,
      );
}

@JsonSerializable(createToJson: false)
class FBCSubscriptionResponse extends BaseResponse {

  final String? due;
  final String? discount;
  final String? productID;
  final String? basePlanID;
  final num? subscriptionId;
  final String? subscription;
  final String? reviewAppStore;
  final String? reviewPlayStore;
  final String? appStoreDownloads;
  final String? playStoreDownloads;
  final List<LocalizedResponse>? moto;
  final List<FeedbackResponse>? feedback;

  FBCSubscriptionResponse({
    required this.due,
    required this.moto,
    required this.feedback,
    required this.discount,
    required this.productID,
    required this.basePlanID,
    required this.subscription,
    required this.subscriptionId,
    required this.reviewAppStore,
    required this.reviewPlayStore,
    required this.appStoreDownloads,
    required this.playStoreDownloads,
  });

  factory FBCSubscriptionResponse.fromJson(Map<String, dynamic> json) =>
      _$FBCSubscriptionResponseFromJson(json);

  Map<String, dynamic> toJson() => {};

  RebornSubscription toEntity() => RebornSubscription(
        reviewAppStore: reviewAppStore ?? '',
        playStoreDownloads: playStoreDownloads ?? '',
        reviewPlayStore: reviewPlayStore ?? '',
        due: due ?? '',
        appStoreDownloads: appStoreDownloads ?? '',
        feedback: feedback?.map((e) => e.toEntity()).toList() ?? [],
        moto: moto?.map((e) => e.toEntity()).toList() ?? [],
        discount: discount ?? '',
        subscription: subscription ?? '',
        basePlanID: basePlanID ?? '',
        productID: productID ?? '',
        subscriptionId: subscriptionId?.toInt() ?? 0,
      );
}
