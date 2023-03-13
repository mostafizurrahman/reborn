import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:reborn/feature/data/models/localized_response.dart';
import 'package:reborn/feature/data/network/firebase_api.dart';
import 'package:reborn/feature/domain/entities.dart';

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
  final String? appStoreDownloads;
  final String? discount;
  final String? due;
  final List<FeedbackResponse>? feedback;
  final List<LocalizedResponse>? moto;
  final String? playStoreDownloads;
  final String? reviewPlayStore;
  final String? subscription;
  final String? reviewAppStore;

  FBCSubscriptionResponse({
    required this.feedback,
    required this.moto,
    required this.appStoreDownloads,
    required this.playStoreDownloads,
    required this.reviewPlayStore,
    required this.subscription,
    required this.due,
    required this.discount,
    required this.reviewAppStore,
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
      );
}
