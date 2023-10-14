import 'package:json_annotation/json_annotation.dart';



import '../../../domain/entities.dart';
import '../../../domain/firebase/entities/reborn_author.dart';
import '../../network/firebase_api.dart';
import '../localized_response.dart';

part 'fb_author_response.g.dart';

@JsonSerializable(createToJson: false)
class FBAuthorResponse extends BaseResponse {
  final String? authorID;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? profilePicture;
  final String? coverPicture;
  final LocalizedResponse? description;
  final LocalizedResponse? motivation;
  final LocalizedResponse? biography;
  final num? duration;
  final LocalizedResponse? professionalTitle;
  final double? averageRating;
  final int? playCount;
  final int? followers;
  final List<String>? trackIdList;
  final List<String>? categoryIdList;
  final List<String>? studentIdList; //list of user id(s) whom he/she instructing.
  final String? country;
  final String? flagIcon;

  FBAuthorResponse({
    required this.authorID,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.profilePicture,
    required this.coverPicture,
    required this.description,
    required this.motivation,
    required this.biography,
    required this.duration,
    required this.professionalTitle,
    required this.averageRating,
    required this.playCount,
    required this.followers,
    required this.trackIdList,
    required this.categoryIdList,
    required this.studentIdList,
    required this.country,
    required this.flagIcon,
  });

  factory FBAuthorResponse.fromJson(Map<String, dynamic> json) => _$FBAuthorResponseFromJson(json);

  Map<String, dynamic> toJson() => {};

  RebornAuthor toEntity() => RebornAuthor(
        authorID: authorID ?? '',
        firstName: firstName ?? "",
        lastName: lastName ?? "",
        email: email ?? '',
        phone: phone ?? '',
        professionalTitle: professionalTitle?.toEntity() ?? emptyTxt,
        coverPicture: coverPicture ?? '',
        description: description?.toEntity() ?? emptyTxt,
        motivation: motivation?.toEntity() ?? emptyTxt,
        biography: biography?.toEntity() ?? emptyTxt,
        duration: duration ?? 0,
        profilePicture: profilePicture ?? '',
        averageRating: averageRating ?? 0,
        playCount: playCount ?? 0,
        followers: followers ?? 0,
        trackIdList: trackIdList ?? [],
        categoryIdList: categoryIdList ?? [],
        studentIdList: studentIdList ?? [],
        country: country ?? '',
        flagIcon: flagIcon ?? '',
      );
}
