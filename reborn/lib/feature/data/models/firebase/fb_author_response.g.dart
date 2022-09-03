// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fb_author_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBAuthorResponse _$FBAuthorResponseFromJson(Map<String, dynamic> json) =>
    FBAuthorResponse(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      profilePicture: json['profilePicture'] as String?,
      coverPicture: json['coverPicture'] as String?,
      description: json['description'] as String?,
      motivation: json['motivation'] as String?,
      biography: json['biography'] as String?,
      duration: json['duration'] as num?,
      professionalTitle: json['professionalTitle'] as String?,
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      playCount: json['playCount'] as int?,
      followers: json['followers'] as int?,
      trackList: (json['trackList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      categoryList: (json['categoryList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      studentIdList: (json['studentIdList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      country: json['country'] as String?,
      flagIcon: json['flagIcon'] as String?,
    );
