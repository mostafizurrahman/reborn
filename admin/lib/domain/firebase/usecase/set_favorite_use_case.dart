
import '../../../firebase/firebase_handler.dart';
import '../../base_use_case.dart';
import '../entities/track_entity.dart';
import '../user_info.dart';

class SetFavoriteTrackUseCase extends BaseUseCase<bool, TrackEntity> {

  @override
  Future<bool> call(final TrackEntity input) async {
    final String deviceID = userInfo.deviceID;
    return await firebase.setFavorite(trackEntity: input, deviceID: deviceID);
  }
}