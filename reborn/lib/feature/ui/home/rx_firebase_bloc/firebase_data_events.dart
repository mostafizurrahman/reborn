import 'package:reborn/feature/data_model/base/base_event.dart';
import 'package:reborn/feature/domain/firebase/entities/reborn_author.dart';
import 'package:reborn/feature/domain/firebase/entities/reborn_category.dart';
import 'package:reborn/feature/domain/firebase/entities/track_entity.dart';

class FirebaseDataEvent extends CCBaseEvent {

}


class LoadFirebaseDataEvent extends FirebaseDataEvent {

  LoadFirebaseDataEvent();
}

class CompleteFirebaseDataEvent extends FirebaseDataEvent {
  final List<RebornCategory> categories;
  final List<RebornAuthor> authors;
  final List<TrackEntity> tracks;
  CompleteFirebaseDataEvent({
    required this.categories,
    required this.tracks,
    required this.authors,
  });
}