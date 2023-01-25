



import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/firebase/firebase_handler.dart';
import 'package:reborn/utility/user_info.dart';
import '../../base_use_case.dart';

class UpdateTrackInfoUseCase extends BaseUseCase<bool, TrackEntity> {
  @override
  Future<bool> call(final TrackEntity input) async {
    final String deviceID = userInfo.deviceID;
    return await firebase.setFavorite(trackEntity: input, deviceID: deviceID);
  }
}