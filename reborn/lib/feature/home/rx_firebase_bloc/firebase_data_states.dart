import 'package:reborn/feature/data/models/firebase/fb_track_response.dart';
import 'package:reborn/feature/data_model/base/base_state.dart';
import 'package:reborn/feature/domain/entities.dart';

class FirebaseDataState extends CCBaseState {}

class FirebaseDataErrorState extends FirebaseDataState {}

class FirebaseDataLoadingState extends FirebaseDataState {}

class FirebaseDataReadyState extends FirebaseDataState {
  final List<FBCategory> categories;
  final List<FBAuthor> authors;
  final List<TrackEntity> tracks;
  FirebaseDataReadyState({
    required this.categories,
    required this.tracks,
    required this.authors,
  });
}
