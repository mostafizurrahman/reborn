import 'package:reborn/feature/domain/base_use_case.dart';
import 'package:reborn/feature/domain/entities.dart';

import 'package:collection/collection.dart';
import 'package:reborn/utility/data_formatter.dart';

class GetSummaryUseCase extends BaseUseCase<CategorySummary, RebornCategory> {
  final List<TrackEntity> tracks;
  final List<RebornAuthor> authors;

  GetSummaryUseCase({
    required this.tracks,
    required this.authors,
  });

  @override
  Future<CategorySummary> call(final RebornCategory input) async {
    final List<TrackEntity> _tracks = input.tracksIdList.map(_getTrack).toList();
    final List<RebornAuthor> _authors = _getAuthors(_tracks);
    final List<String> _summaryTxt = _getSummaryText(_tracks);
    _summaryTxt.add("${_authors.length} Coaches");
    final CategorySummary summary = CategorySummary(
      authors: _authors,
      tracks: _tracks,
      summary: _summaryTxt,
    );
    return Future.value(summary);
  }

  TrackEntity _getTrack(final String trackID) {
    final track = tracks.firstWhereOrNull((element) => element.trackID == trackID);
    print("Track -- ${track?.trackID} -- Author ${track?.authorID}");
    if (track != null) {
      final author = authors.firstWhereOrNull((element) => element.authorID == track.authorID);
      track.trackAuthor = author;
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
