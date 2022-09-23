// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fb_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBCategoryResponse _$FBCategoryResponseFromJson(Map<String, dynamic> json) =>
    FBCategoryResponse(
      categoryID: json['categoryID'] as String?,
      hasLogo: json['hasLogo'] as bool?,
      isVisible: json['isVisible'] as bool?,
      logoData: json['logoData'] as num?,
      displayOrder: json['displayOrder'] as int?,
      seeMore: json['seeMore'] as bool?,
      title: json['title'] == null
          ? null
          : LocalizedResponse.fromJson(json['title'] as Map<String, dynamic>),
      seeMoreTitle: json['seeMoreTitle'] == null
          ? null
          : LocalizedResponse.fromJson(
              json['seeMoreTitle'] as Map<String, dynamic>),
      tracksType: json['tracksType'] as String?,
      trackIdList: (json['trackIdList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      description: json['description'] == null
          ? null
          : LocalizedResponse.fromJson(
              json['description'] as Map<String, dynamic>),
      categoryType: json['categoryType'] as String?,
      coverImage: json['coverImage'] as String?,
    );
