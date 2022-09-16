// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fb_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBUserResponse _$FBUserResponseFromJson(Map<String, dynamic> json) =>
    FBUserResponse(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      professionalTitle: json['professionalTitle'] as String?,
      profilePicture: json['profilePicture'] as String?,
      trackTypeList: (json['trackTypeList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      favoriteTrackList: (json['favoriteTrackList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      profileCoverImage: json['profileCoverImage'] as String?,
      isPremiumUser: json['isPremiumUser'] as bool?,
      subscriptionCount: json['subscriptionCount'] as int,
      dateEndSubscribe: json['dateEndSubscribe'] as String?,
      dateSubscription: json['dateSubscription'] as String?,
      userID: json['userID'] as String?,
    );
