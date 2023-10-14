import '../../../data/models/firebase/fb_error_response.dart';
import '../../../data/models/firebase/fb_track_response.dart';
import '../../../data/network/firebase_api.dart';
import '../../base_use_case.dart';
import '../../entities.dart';
import '../entities/search_data.dart';


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