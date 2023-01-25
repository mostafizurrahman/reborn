import 'package:reborn/feature/domain/entities.dart';

class PlayerInfoEntity {
  int likeCount;
  int totalPlayed;
  PlayerInfoEntity({required this.likeCount, required this.totalPlayed});
  Map<String, dynamic> toJson() => _$PlayerInfoToJson(this);

  PlayerInfoEntity copyWith({final int? like, final int? played}) =>
      PlayerInfoEntity(
        likeCount: like ?? likeCount,
        totalPlayed: played ?? totalPlayed,
      );
}

Map<String, dynamic> _$PlayerInfoToJson(PlayerInfoEntity instance) =>
    <String, dynamic>{
      'likeCount': instance.likeCount,
      'totalPlayed': instance.totalPlayed,
    };

class TrackEntity {
  final LocalizedText trackTitle;
  final LocalizedText trackSubtitle;
  final int trackDuration;
  final String trackID;
  //["Popular", "Mediation", "Sleep", "Music" ... ]
  final List<String> generList;
  final LocalizedText story;
  final String authorID;
  final String trackType;
  final String trackCoverImage;
  final String trackAudio;
  final String trackSecret;
  final bool isLocalTrack;
  final int trackIconData;
  final bool isPremium;
  final PlayerInfoEntity playerInfo;

  RebornAuthor? trackAuthor;

  TrackEntity({
    required this.trackID,
    required this.trackTitle,
    required this.trackSubtitle,
    required this.trackDuration,
    required this.authorID,
    required this.trackType,
    required this.trackCoverImage,
    required this.isPremium,
    required this.generList,
    required this.trackIconData,
    required this.playerInfo,
    required this.story,
    required this.isLocalTrack,
    required this.trackSecret,
    required this.trackAudio,
  });

  Map<String, dynamic> toJson() => _$TrackEntityToJson(this);
}

Map<String, dynamic> _$TrackEntityToJson(TrackEntity instance) =>
    <String, dynamic>{
      'trackTitle': instance.trackTitle.toJson(),
      'trackSubtitle': instance.trackSubtitle.toJson(),
      'trackDuration': instance.trackDuration,
      'generList': instance.generList,
      'story': instance.story.toJson(),
      'authorID': instance.authorID,
      'trackType': instance.trackType,
      'trackCoverImage': instance.trackCoverImage,
      'trackAudio': instance.trackAudio,
      'trackSecret': instance.trackSecret,
      'isLocalTrack': instance.isLocalTrack,
      'trackIconData': instance.trackIconData,
      'isPremium': instance.isPremium,
      'playerInfo': instance.playerInfo.toJson(),
      'trackID': instance.trackID,
    };
