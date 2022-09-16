

import '../../data_model/base/base_event.dart';
import '../../domain/entities.dart';

class FirebaseDataEvent extends CCBaseEvent {

}


class LoadFirebaseDataEvent extends FirebaseDataEvent {

  LoadFirebaseDataEvent();
}

class CompleteFirebaseDataEvent extends FirebaseDataEvent {
  final List<RebornCategory> categories;
  final List<FBAuthor> authors;
  final List<TrackEntity> tracks;
  CompleteFirebaseDataEvent({
    required this.categories,
    required this.tracks,
    required this.authors,
  });
}