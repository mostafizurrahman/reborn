// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fb_subscription_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackResponse _$FeedbackResponseFromJson(Map<String, dynamic> json) =>
    FeedbackResponse(
      id: json['id'] as String?,
      image: json['image'] as String?,
      name: json['name'] == null
          ? null
          : LocalizedResponse.fromJson(json['name'] as Map<String, dynamic>),
      review: json['review'] == null
          ? null
          : LocalizedResponse.fromJson(json['review'] as Map<String, dynamic>),
      title: json['title'] == null
          ? null
          : LocalizedResponse.fromJson(json['title'] as Map<String, dynamic>),
      stars: json['stars'] as String?,
    );

FBCSubscriptionResponse _$FBCSubscriptionResponseFromJson(
        Map<String, dynamic> json) =>
    FBCSubscriptionResponse(
      due: json['due'] as String?,
      moto: (json['moto'] as List<dynamic>?)
          ?.map((e) => LocalizedResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      feedback: (json['feedback'] as List<dynamic>?)
          ?.map((e) => FeedbackResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      discount: json['discount'] as String?,
      productID: json['productID'] as String?,
      basePlanID: json['basePlanID'] as String?,
      subscription: json['subscription'] as String?,
      subscriptionId: json['subscriptionId'] as num?,
      reviewAppStore: json['reviewAppStore'] as String?,
      reviewPlayStore: json['reviewPlayStore'] as String?,
      appStoreDownloads: json['appStoreDownloads'] as String?,
      playStoreDownloads: json['playStoreDownloads'] as String?,
    );
