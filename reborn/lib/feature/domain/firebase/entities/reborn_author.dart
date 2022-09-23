import '../../entities.dart';

class RebornAuthor {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String profilePicture;
  final String coverPicture;
  final LocalizedText description;
  final LocalizedText motivation;
  final LocalizedText biography;
  final num duration;
  final LocalizedText professionalTitle;
  final double averageRating;
  final int playCount;
  final int followers;
  final List<String> trackIdList;
  final List<String> categoryIdList;
  final List<String> studentIdList; //list of user id(s) whom he/she instructing.
  final String country;
  final String flagIcon;
  final String authorID;
  RebornAuthor({
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
}
