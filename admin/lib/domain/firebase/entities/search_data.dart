

import 'package:admin/domain/firebase/entities/reborn_category.dart';
import 'package:admin/domain/firebase/entities/reborn_name_data.dart';
import 'package:admin/domain/firebase/entities/track_entity.dart';

class LocalSearchData {
  final List<RebornFilterData> listData;
  final List<RebornFilterData> gridData;
  final List<TrackEntity> tracks;
  final List<RebornCategory> categories;
  LocalSearchData({
    required this.categories,
    required this.tracks,
    this.listData = const [],
    this.gridData = const [],
  });

}

class AuthorSearchData {}

class CategorySearchData {}

class TrackSearchData {}
