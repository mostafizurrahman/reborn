// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fb_track_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBTrackResponse _$FBTrackResponseFromJson(Map<String, dynamic> json) =>
    FBTrackResponse(
      trackTitle: json['trackTitle'] == null
          ? null
          : LocalizedResponse.fromJson(
              json['trackTitle'] as Map<String, dynamic>),
      trackSubtitle: json['trackSubtitle'] == null
          ? null
          : LocalizedResponse.fromJson(
              json['trackSubtitle'] as Map<String, dynamic>),
      trackDuration: json['trackDuration'] == null
          ? null
          : LocalizedResponse.fromJson(
              json['trackDuration'] as Map<String, dynamic>),
      authorTitle: json['authorTitle'] == null
          ? null
          : LocalizedResponse.fromJson(
              json['authorTitle'] as Map<String, dynamic>),
      trackTypeList: (json['trackTypeList'] as List<dynamic>?)
          ?.map((e) => LocalizedResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      authorID: json['authorID'] as String?,
      trackType: json['trackType'] as String?,
    );
