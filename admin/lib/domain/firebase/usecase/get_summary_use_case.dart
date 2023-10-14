

import 'package:collection/collection.dart';

import '../../base_use_case.dart';
import '../../entities.dart';
import '../entities/data_formatter.dart';

class GetSummaryUseCase extends BaseUseCase<CategorySummary, RebornCategory> {
  final List<TrackEntity> tracks;
  final List<RebornAuthor> authors;

  GetSummaryUseCase({
    required this.tracks,
    required this.authors,
  });

  @override
  Future<CategorySummary> call(final RebornCategory input) async {
    final List<TrackEntity> tracks = input.tracksIdList.map(_getTrack).toList();
    final List<RebornAuthor> authors = _getAuthors(tracks);
    final List<String> summaryTxt = _getSummaryText(tracks);
    summaryTxt.add("${authors.length} Coaches");
    final CategorySummary summary = CategorySummary(
      authors: authors,
      tracks: tracks,
      summary: summaryTxt,
      title: input.title,
      coverImage: input.categoryCover ?? "",
      logoData: input.logoData.toInt(),
    );
    return Future.value(summary);
  }

  TrackEntity _getTrack(final String trackID) {
    final track = tracks.firstWhereOrNull((element) => element.trackID == trackID);
    if (track != null) {
      authors.firstWhereOrNull(track.setAuthor);
      return track;
    }
    return tracks.last;
  }

  List<RebornAuthor> _getAuthors(List<TrackEntity> tracks) {
    final Set<String> authorSet = {};
    for(final track in tracks) {
      authorSet.add(track.authorID);
    }
    // tracks.where((element) => authorSet.add(element.authorID));
    final List<String> authorIdList = authorSet.toList();
    final List<RebornAuthor> authorList = [];

    for (final author in authors) {
      if (authorIdList.contains(author.authorID)) {
        authorList.add(author);
      }
    }
    return authorList;
  }

  List<String> _getSummaryText(final List<TrackEntity> _tracks) {

    double seconds = 0;
    for (final track in _tracks) {
      seconds += track.trackDuration;
    }
    final Duration duration = Duration(seconds: seconds.toInt());
    final String formatted = DataFormatter.formattedDuration(duration);
    return [
      "$formatted ${formatted.length > 5 ? "Hr" : "Min"}",
      "${_tracks.length} Tracks",
    ];
  }
}
