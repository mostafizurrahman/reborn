

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
    return CategoryTrackType.gridTrack;
  }
}

class LocalizedText {
  final String en;
  final String ru;
  LocalizedText({required this.en, required this.ru});
}

final emptyTxt = LocalizedText(en: '', ru: '');