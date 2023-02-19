

import 'package:reborn/feature/domain/base_use_case.dart';
import 'package:reborn/feature/domain/firebase/entities/reborn_category.dart';
import 'package:reborn/feature/domain/firebase/entities/reborn_name_data.dart';
import 'package:reborn/feature/firebase/firebase_handler.dart';

import '../entities/search_data.dart';

class GetSleepCategoryUseCase
    implements BaseUseCase<List<RebornCategory>, LocalSearchData> {

  final List<RebornFilterData> gridFilter;
  final List<RebornFilterData> listFilter;
  final List<RebornCategory> categories;
  GetSleepCategoryUseCase({required this.categories, required this.gridFilter, required this.listFilter});

  @override
  Future<List<RebornCategory>> call(final LocalSearchData searchData) async {

    final List<RebornCategory> categoryList = [];

    if (gridFilter.isNotEmpty) {
      for(final data in gridFilter) {
        for(final cat in categories) {

        }
      }

      return [];
    }
    return categoryList;
  }
}
