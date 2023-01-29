import 'package:reborn/feature/data_model/sqlite_manager.dart';
import 'package:reborn/feature/domain/base_use_case.dart';
import 'package:reborn/utility/cache_storage.dart';

import '../../entities.dart';

class GetFavoriteTracksUseCase extends BaseUseCase<List<TrackEntity>, List<String>> {

  final List<RebornAuthor>authors;
  GetFavoriteTracksUseCase({required this.authors});

  @override
  Future<List<TrackEntity>> call(List<String> input) async {
    final List<TrackEntity> tracks = await sqlDatabase.getFavoriteList(authors: authors);
    final trackIdList = tracks.map((e) => e.trackID).toList();
    final Set<String> diff = input.toSet().difference(trackIdList.toSet());
    if (diff.isNotEmpty) {
      final trackList = await cacheStorage.getTracksFrom(tracks:diff.toList());
      tracks.addAll(trackList);
    }
    return tracks;
  }
}