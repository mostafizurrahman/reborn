
import 'package:reborn/feature/domain/entities.dart';
class PlayerInfoEntity {
  int likeCount;
  int totalPlayed;
  PlayerInfoEntity({required this.likeCount, required this.totalPlayed});

}
class TrackEntity {
  final LocalizedText trackTitle;
  final LocalizedText trackSubtitle;
  final int trackDuration;

  final List<String> generList; //["Popular", "Mediation", "Sleep", "Music" ... ]
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

  TrackEntity({
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
}