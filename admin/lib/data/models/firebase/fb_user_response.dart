
import 'package:json_annotation/json_annotation.dart';

import '../../network/firebase_api.dart';

part 'fb_user_response.g.dart';
@JsonSerializable(createToJson: false)
class FBUserResponse extends BaseResponse{
  final String? firstName;
  final String? lastName;
  final String? profilePicture;
  final String? professionalTitle;
  final List<String>? trackTypeList; //["Popular", "Mediation", "Sleep", "Music" ... ]
  final List<String>? favoriteTrackList;
  final String? userID;
  final String? profileCoverImage;
  final String? dateSubscription;
  final String? dateEndSubscribe;
  final bool? isPremiumUser;
  final int subscriptionCount;


  FBUserResponse({
    required this.firstName,
    required this.lastName,
    required this.professionalTitle,
    required this.profilePicture,
    required this.trackTypeList,
    required this.favoriteTrackList,
    required this.profileCoverImage,
    required this.isPremiumUser,
    required this.subscriptionCount,
    required this.dateEndSubscribe,
    required this.dateSubscription,
    required this.userID,
  });

  factory FBUserResponse.fromJson(Map<String, dynamic> json) => _$FBUserResponseFromJson(json);

  Map<String, dynamic> toJson() => {};
}
