import 'package:reborn/feature/domain/entities.dart';

class CategorySummary {
  final List<RebornAuthor> authors;
  final List<String> summary;
  final List<TrackEntity> tracks;
  String? coverImage;
  int iconData = -1;
  LocalizedText? title;
  CategorySummary({
    required this.tracks,
    required this.summary,
    required this.authors,
    this.coverImage,
    this.title,
  });
}
