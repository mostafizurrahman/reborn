import 'package:reborn/feature/domain/entities.dart';

class CategorySummary {
  final List<RebornAuthor> authors;
  final List<String> summary;
  final List<TrackEntity> tracks;
  CategorySummary({
    required this.tracks,
    required this.summary,
    required this.authors,
  });
}
