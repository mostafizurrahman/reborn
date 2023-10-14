

import '../../entities.dart';

class RebornCategory {
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
  final LocalizedText? description;
  final String categoryType;
  final String? categoryCover;

  RebornCategory({
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
    required this.description,
    required this.categoryType,
    required this.categoryCover,
  });

  RebornCategory copyWith({required final List<String> tracks}) =>
      RebornCategory(
        tracksIdList: tracks,
        categoryID: categoryID,
        displayOrder: displayOrder,
        isVisible: isVisible,
        title: title,
        hasLogo: hasLogo,
        logoData: logoData,
        seeMore: seeMore,
        seeMoreTitle: seeMoreTitle,
        tracksType: tracksType,
        description: description,
        categoryType: categoryType,
        categoryCover: categoryCover,
      );
}
