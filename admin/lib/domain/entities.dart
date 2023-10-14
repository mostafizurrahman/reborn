
import 'package:admin/domain/reborn_lanugage.dart';

export '../domain/firebase/entities/home_reborn_data.dart';
export '../domain/firebase/entities/reborn_author.dart';
export '../domain/firebase/entities/reborn_category.dart';
export '../domain/firebase/entities/reborn_name_data.dart';
export '../domain/firebase/entities/track_entity.dart';
export 'category_summary.dart';

enum CategoryTrackType {
  gridTrack,
  collectionTracks,
  groupCoverTrack,
  coverTrack,
}

extension TrackDsiplayType on String {
  CategoryTrackType get trackType {
    if (this == "grid") {
      return CategoryTrackType.gridTrack;
    }
    if (this == "collectionCollage") {
      return CategoryTrackType.collectionTracks;
    }
    if (this == "groupCover") {
      return CategoryTrackType.groupCoverTrack;
    }
    if (this == "cover") {
      return CategoryTrackType.coverTrack;
    }
    return CategoryTrackType.gridTrack;
  }
}

class LocalizedText {
  final String en;
  final String ru;
  const LocalizedText({required this.en, required this.ru});
  Map<String, dynamic> toJson() => _$LocalizedTextToJson(this);
  String get txt => language.isEnglish ? en : ru;
}

Map<String, dynamic> _$LocalizedTextToJson(LocalizedText instance) =>
    <String, dynamic>{
      'en': instance.en,
      'ru': instance.ru,
    };
const emptyTxt =  LocalizedText(en: '', ru: '');
