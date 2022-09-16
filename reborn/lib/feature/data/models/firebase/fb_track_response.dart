
import 'package:json_annotation/json_annotation.dart';
import 'package:reborn/feature/data/models/localized_response.dart';
import 'package:reborn/feature/data/network/firebase_api.dart';

part 'fb_track_response.g.dart';

@JsonSerializable(createToJson: false)
class PlayerInfo {
  int? likeCount;
  int? totalPlayed;
  PlayerInfo({required this.likeCount, this.totalPlayed});

  factory PlayerInfo.fromJson(Map<String, dynamic> json) => _$PlayerInfoFromJson(json);

  Map<String, dynamic> toJson() => {};
}

@JsonSerializable(createToJson: false)
class FBTrackResponse extends BaseResponse {
  final LocalizedResponse? trackTitle;
  final LocalizedResponse? trackSubtitle;
  final int? trackDuration;

  final List<String>? generList; //["Popular", "Mediation", "Sleep", "Music" ... ]
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

  FBTrackResponse({
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

  factory FBTrackResponse.fromJson(Map<String, dynamic> json) => _$FBTrackResponseFromJson(json);

  Map<String, dynamic> toJson() => {};
}
