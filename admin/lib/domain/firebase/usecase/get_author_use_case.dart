

import 'package:admin/data/models/firebase/fb_author_response.dart';

import '../../../data/models/firebase/fb_error_response.dart';
import '../../../data/network/firebase_api.dart';
import '../../base_use_case.dart';
import '../../entities.dart';
import '../entities/reborn_author.dart';
import '../entities/search_data.dart';


class GetAuthorUseCase implements BaseUseCase<List<RebornAuthor>, AuthorSearchData> {

  final FirebaseAuthorApi _authorApi = FirebaseAuthorApi();
  @override
  Future<List<RebornAuthor>> call(AuthorSearchData input) async {
    final List<FBAuthorResponse>  authorResponseList = await _authorApi.getList();
    if (authorResponseList.isNotEmpty && authorResponseList.first is FBErrorResponse) {
      return [];
    }
    final List<RebornAuthor> authors = authorResponseList.map((e) => e.toEntity()).toList();
    return authors;
  }

}