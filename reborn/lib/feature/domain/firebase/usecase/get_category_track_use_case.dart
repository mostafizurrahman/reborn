


import 'package:reborn/feature/domain/base_use_case.dart';
import 'package:reborn/feature/domain/entities.dart';

import 'package:collection/collection.dart';

class GetCategoryTrackUseCase extends BaseUseCase<List<TrackEntity>, List<String>>{

  final List<TrackEntity> trackList;
  final List<RebornAuthor> authorList;
  GetCategoryTrackUseCase({required this.trackList, required this.authorList});
  @override
  Future<List<TrackEntity>> call(List<String> input) async {
    final List<TrackEntity> _tracks = input.map(_getTrack).toList();
    return Future.value(_tracks);
  }

  List<TrackEntity> getFilterList(List<String> input)  {
    final List<TrackEntity> _tracks = input.map(_getTrack).toList();
    return _tracks;
  }
  
  TrackEntity _getTrack(final String trackID) {
    final track = trackList.firstWhereOrNull((element) => element.trackID == trackID);
    if (track != null) {
      final author = authorList.firstWhereOrNull((element) => element.authorID == track.authorID);
      track.trackAuthor = author;
      return track;
    }
    return trackList.first;
  }
  
}