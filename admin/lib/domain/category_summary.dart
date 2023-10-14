

import 'package:admin/domain/entities.dart';

class CategorySummary {
  final List<RebornAuthor> authors;
  final List<String> summary;
  final List<TrackEntity> tracks;
  final String coverImage;
  final int logoData;
  final LocalizedText title;
  bool get isLocal => logoData == -1;
  CategorySummary({
    required this.tracks,
    required this.summary,
    required this.authors,
    required this.coverImage,
    required this.title,
    required this.logoData,
  });
}
