
import 'package:json_annotation/json_annotation.dart';
import 'package:reborn/feature/data/models/localized_response.dart';

part 'fb_track_response.g.dart';

@JsonSerializable(createToJson: false)
class PlayerInfo {
  int? likeCount;
  int? totalPlay;
  PlayerInfo({required this.likeCount, this.totalPlay});

  factory PlayerInfo.fromJson(Map<String, dynamic> json) => _$PlayerInfoFromJson(json);

  Map<String, dynamic> toJson() => {};
}

@JsonSerializable(createToJson: false)
class FBTrackResponse {
  final LocalizedResponse? trackTitle;
  final LocalizedResponse? trackSubtitle;
  final LocalizedResponse? trackDuration;
  final LocalizedResponse? authorTitle;
  final List<LocalizedResponse>? trackTypeList; //["Popular", "Mediation", "Sleep", "Music" ... ]
  final LocalizedResponse? story;
  final String? authorID;
  final String? trackType;
  final String? trackCoverPhoto;
  final String? trackAudio;
  final String? trackSecret;
  final bool? isLocalTrack;
  final int? trackIconData;
  final bool? isPremium;
  final List<String> generList;
  final PlayerInfo? playerInfo;

  FBTrackResponse({
    required this.trackTitle,
    required this.trackSubtitle,
    required this.trackDuration,
    required this.authorTitle,
    required this.trackTypeList,
    required this.authorID,
    required this.trackType,
    required this.trackCoverPhoto,
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
