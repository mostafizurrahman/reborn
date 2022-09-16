// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fb_track_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerInfo _$PlayerInfoFromJson(Map<String, dynamic> json) => PlayerInfo(
      likeCount: json['likeCount'] as int?,
      totalPlayed: json['totalPlayed'] as int?,
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
      trackDuration: json['trackDuration'] as int?,
      authorID: json['authorID'] as String?,
      trackType: json['trackType'] as String?,
      trackCoverImage: json['trackCoverImage'] as String?,
      isPremium: json['isPremium'] as bool?,
      generList: (json['generList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
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
      trackID: json['trackID'] as String?,
    );
