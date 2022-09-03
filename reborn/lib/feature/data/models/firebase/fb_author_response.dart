import 'package:json_annotation/json_annotation.dart';
import 'package:reborn/feature/domain/firebase/entities/fb_author.dart';

part 'fb_author_response.g.dart';

@JsonSerializable(createToJson: false)
class FBAuthorResponse {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? profilePicture;
  final String? coverPicture;
  final String? description;
  final String? motivation;
  final String? biography;
  final num? duration;
  final String? professionalTitle;
  final double? averageRating;
  final int? playCount;
  final int? followers;
  final List<String>? trackList;
  final List<String>? categoryList;
  final List<String>? studentIdList; //list of user id(s) whom he/she instructing.
  final String? country;
  final String? flagIcon;

  FBAuthorResponse({
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
    required this.trackList,
    required this.categoryList,
    required this.studentIdList,
    required this.country,
    required this.flagIcon,
  });

  factory FBAuthorResponse.fromJson(Map<String, dynamic> json) =>
      _$FBAuthorResponseFromJson(json);

  Map<String, dynamic> toJson() => {};

  FBAuthor toEntity() => FBAuthor(
    firstName: firstName ?? "",
    lastName: lastName ?? "",
    email: email ?? '',
    phone: phone ?? '',
    professionalTitle: profilePicture ?? '',
    coverPicture: coverPicture ?? '',
    description: description ?? '',
    motivation: motivation ?? '',
    biography: biography ?? '',
    duration: duration ?? 0,
    profilePicture: professionalTitle ?? '',
    averageRating: averageRating ?? 0,
    playCount: playCount ?? 0,
    followers: followers ?? 0,
    trackList: trackList ?? [],
    categoryList: categoryList ?? [],
    studentIdList: studentIdList ?? [],
    country: country ?? '',
    flagIcon: flagIcon ?? '',
  );
}
