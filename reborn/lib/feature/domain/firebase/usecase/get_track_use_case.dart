

import 'package:reborn/feature/data/models/firebase/fb_error_response.dart';
import 'package:reborn/feature/data/models/firebase/fb_track_response.dart';
import 'package:reborn/feature/data/network/firebase_api.dart';
import 'package:reborn/feature/domain/firebase/entities/track_entity.dart';
import '../../base_use_case.dart';
import '../../entities.dart';


class GetTrackUseCase implements BaseUseCase<List<TrackEntity>, TrackSearchData> {

  final FirebaseTrackApi _trackApi = FirebaseTrackApi();
  @override
  Future<List<TrackEntity>> call(final TrackSearchData searchData) async {
    final List<FBTrackResponse>  trackList = await _trackApi.getList();
    if (trackList.isNotEmpty && trackList.first is FBErrorResponse) {
      return [];
    }
    final List<TrackEntity> tracks = trackList.map((e) => e.toEntity()).toList();
    return tracks;
  }
}