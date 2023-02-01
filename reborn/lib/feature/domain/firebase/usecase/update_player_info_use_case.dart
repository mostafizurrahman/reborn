
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/firebase/firebase_handler.dart';
import '../../base_use_case.dart';

class UpdateTrackInfoUseCase extends BaseUseCase<bool, PlayerInfoEntity> {
  final TrackEntity track;
  UpdateTrackInfoUseCase({required this.track});
  @override
  Future<bool> call(final PlayerInfoEntity input) async {
    return await firebase.updatePlayerInfo(track, input.totalPlayed, input.likeCount);
  }
}