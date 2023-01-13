
import 'package:reborn/feature/domain/entities.dart';
import '../../base_use_case.dart';

class SetFavoriteTrackUseCase extends BaseUseCase<bool, TrackEntity> {
  @override
  Future<bool> call(final TrackEntity input) async {




    return Future.value(true);
  }
}