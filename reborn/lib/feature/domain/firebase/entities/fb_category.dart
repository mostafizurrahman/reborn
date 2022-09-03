import 'package:reborn/feature/domain/entities.dart';

class FBCategory {

  final String categoryID;
  final bool hasLogo;
  final bool isVisible;
  final num logoData;
  final int displayOrder;
  final bool seeMore;
  final LocalizedText title;
  final LocalizedText seeMoreTitle;
  final CategoryTrackType tracksType;
  final List<String> tracksIdList;

  FBCategory({
    required this.categoryID,
    required this.displayOrder,
    required this.isVisible,
    required this.title,
    required this.hasLogo,
    required this.logoData,
    required this.seeMore,
    required this.seeMoreTitle,
    required this.tracksType,
    required this.tracksIdList,
  });
}
