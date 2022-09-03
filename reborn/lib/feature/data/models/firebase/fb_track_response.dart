import 'package:json_annotation/json_annotation.dart';
import 'package:reborn/feature/data/models/localized_response.dart';

part 'fb_track_response.g.dart';

@JsonSerializable(createToJson: false)
class FBTrackResponse {
  final LocalizedResponse? trackTitle;
  final LocalizedResponse? trackSubtitle;
  final LocalizedResponse? trackDuration;
  final LocalizedResponse? authorTitle;
  final List<LocalizedResponse>? trackTypeList; //["Popular", "Mediation", "Sleep", "Music" ... ]
  final String? authorID;
  final String? trackType;
  FBTrackResponse({
    required this.trackTitle,
    required this.trackSubtitle,
    required this.trackDuration,
    required this.authorTitle,
    required this.trackTypeList,
    required this.authorID,
    required this.trackType,
  });

  factory FBTrackResponse.fromJson(Map<String, dynamic> json) => _$FBTrackResponseFromJson(json);

  Map<String, dynamic> toJson() => {};
}
