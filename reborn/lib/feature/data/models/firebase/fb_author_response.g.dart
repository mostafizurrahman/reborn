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
      description: json['description'] == null
          ? null
          : LocalizedResponse.fromJson(
              json['description'] as Map<String, dynamic>),
      motivation: json['motivation'] == null
          ? null
          : LocalizedResponse.fromJson(
              json['motivation'] as Map<String, dynamic>),
      biography: json['biography'] == null
          ? null
          : LocalizedResponse.fromJson(
              json['biography'] as Map<String, dynamic>),
      duration: json['duration'] as num?,
      professionalTitle: json['professionalTitle'] == null
          ? null
          : LocalizedResponse.fromJson(
              json['professionalTitle'] as Map<String, dynamic>),
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      playCount: json['playCount'] as int?,
      followers: json['followers'] as int?,
      trackIdList: (json['trackIdList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      categoryIdList: (json['categoryIdList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      studentIdList: (json['studentIdList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      country: json['country'] as String?,
      flagIcon: json['flagIcon'] as String?,
    );
