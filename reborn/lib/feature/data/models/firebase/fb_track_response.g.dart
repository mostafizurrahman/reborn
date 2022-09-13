// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fb_track_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerInfo _$PlayerInfoFromJson(Map<String, dynamic> json) => PlayerInfo(
      likeCount: json['likeCount'] as int?,
      totalPlay: json['totalPlay'] as int?,
    );

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
      trackCoverPhoto: json['trackCoverPhoto'] as String?,
      isPremium: json['isPremium'] as bool?,
      generList:
          (json['generList'] as List<dynamic>).map((e) => e as String).toList(),
      trackIconData: json['trackIconData'] as int?,
      playerInfo: json['playerInfo'] == null
          ? null
          : PlayerInfo.fromJson(json['playerInfo'] as Map<String, dynamic>),
      story: json['story'] == null
          ? null
          : LocalizedResponse.fromJson(json['story'] as Map<String, dynamic>),
      isLocalTrack: json['isLocalTrack'] as bool?,
      trackSecret: json['trackSecret'] as String?,
      trackAudio: json['trackAudio'] as String?,
    );
