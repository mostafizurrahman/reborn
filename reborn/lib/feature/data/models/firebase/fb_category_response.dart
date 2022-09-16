import 'package:json_annotation/json_annotation.dart';
import 'package:reborn/feature/data/network/firebase_api.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/domain/firebase/entities/fb_author.dart';
import 'package:reborn/feature/domain/firebase/entities/fb_category.dart';

import '../localized_response.dart';

part 'fb_category_response.g.dart';

@JsonSerializable(createToJson: false)
class FBCategoryResponse extends BaseResponse{
  final String? categoryID;
  final bool? hasLogo;
  final bool? isVisible;
  final num? logoData;
  final int? displayOrder;
  final bool? seeMore;
  final LocalizedResponse? title;
  final LocalizedResponse? seeMoreTitle;
  final String? tracksType;
  final List<String>? trackIdList;

  FBCategoryResponse({
    required this.categoryID,
    required this.hasLogo,
    required this.isVisible,
    required this.logoData,
    required this.displayOrder,
    required this.seeMore,
    required this.title,
    required this.seeMoreTitle,
    required this.tracksType,
    required this.trackIdList,
  });

  factory FBCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$FBCategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => {};

  RebornCategory toEntity() => RebornCategory(
        categoryID: categoryID ?? '',
        hasLogo: hasLogo ?? false,
        logoData: logoData ?? -1,
        isVisible: isVisible ?? true,
        displayOrder: displayOrder ?? 0,
        seeMore: seeMore ?? true,
        seeMoreTitle: seeMoreTitle?.toEntity() ?? emptyTxt,
        title: title?.toEntity() ?? emptyTxt,
        tracksIdList: trackIdList ?? [],
        tracksType: tracksType?.trackType ?? CategoryTrackType.gridTrack,
      );
}
