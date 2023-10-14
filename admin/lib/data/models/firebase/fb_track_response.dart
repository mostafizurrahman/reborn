import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities.dart';
import '../../../domain/firebase/entities/track_entity.dart';
import '../../network/firebase_api.dart';
import '../localized_response.dart';

part 'fb_track_response.g.dart';

@JsonSerializable(createToJson: false)
class PlayerInfo {
  int? likeCount;
  int? totalPlayed;

  PlayerInfo({required this.likeCount, this.totalPlayed});

  factory PlayerInfo.fromJson(Map<String, dynamic> json) =>
      _$PlayerInfoFromJson(json);

  Map<String, dynamic> toJson() => {};

  PlayerInfoEntity toEntity() => PlayerInfoEntity(
      likeCount: likeCount ?? 0, totalPlayed: totalPlayed ?? 0);
}

@JsonSerializable(createToJson: false)
class FBTrackResponse extends BaseResponse {
  final LocalizedResponse? trackTitle;
  final LocalizedResponse? trackSubtitle;
  final int? trackDuration;

  final List<String>?
      generList; //["Popular", "Mediation", "Sleep", "Music" ... ]
  final LocalizedResponse? story;
  final String? authorID;
  final String? trackType;
  final String? trackCoverImage;
  final String? trackAudio;
  final String? trackSecret;
  final bool? isLocalTrack;
  final int? trackIconData;
  final bool? isPremium;
  final PlayerInfo? playerInfo;
  final String? trackID;
  final String? documentId;

  FBTrackResponse({
    required this.documentId,
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
    required this.trackID,
  });

  factory FBTrackResponse.fromJson(Map<String, dynamic> json) =>
      _$FBTrackResponseFromJson(json);

  Map<String, dynamic> toJson() => {};

  TrackEntity toEntity() => TrackEntity(
        documentId: documentId ?? '--',
        trackTitle: trackTitle?.toEntity() ?? emptyTxt,
        trackSubtitle: trackSubtitle?.toEntity() ?? emptyTxt,
        trackDuration: trackDuration ?? 0,
        authorID: authorID ?? '',
        trackType: trackType ?? '',
        trackCoverImage: trackCoverImage ?? '',
        isPremium: isPremium ?? false,
        generList: generList?.map((e) => e.toLowerCase()).toList() ?? [],
        trackIconData: trackIconData ?? 0,
        playerInfo: playerInfo?.toEntity() ??
            PlayerInfoEntity(likeCount: 0, totalPlayed: 0),
        story: story?.toEntity() ?? emptyTxt,
        isLocalTrack: isLocalTrack ?? false,
        trackSecret: trackSecret ?? '',
        trackAudio: trackAudio ?? '',
        trackID: trackID ?? '',
      );
}
