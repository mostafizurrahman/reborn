


import '../../../data/models/firebase/fb_category_response.dart';
import '../../../data/models/firebase/fb_error_response.dart';
import '../../../data/network/firebase_api.dart';
import '../../base_use_case.dart';
import '../../entities.dart';
import '../entities/search_data.dart';


class GetCategoryUseCase implements BaseUseCase<List<RebornCategory>, CategorySearchData> {

  final FirebaseCategoryApi _categoryApi = FirebaseCategoryApi();
  @override
  Future<List<RebornCategory>> call(final CategorySearchData searchData) async {
    final List<FBCategoryResponse>  categoryList = await _categoryApi.getList();
    if (categoryList.isNotEmpty && categoryList.first is FBErrorResponse) {
      return [];
    }
    final List<RebornCategory> authors = categoryList.map((e) => e.toEntity()).toList();
    return authors;
  }
}