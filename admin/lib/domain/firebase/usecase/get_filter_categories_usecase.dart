


import '../../base_use_case.dart';
import '../../entities.dart';
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
