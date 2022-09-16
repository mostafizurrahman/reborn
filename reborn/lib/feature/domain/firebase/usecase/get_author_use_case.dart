

import 'package:reborn/feature/data/models/firebase/fb_author_response.dart';
import 'package:reborn/feature/data/models/firebase/fb_error_response.dart';
import 'package:reborn/feature/data/network/firebase_api.dart';
import '../../base_use_case.dart';
import '../../entities.dart';


class GetAuthorUseCase implements BaseUseCase<List<FBAuthor>, AuthorSearchData> {

  final FirebaseAuthorApi _authorApi = FirebaseAuthorApi();
  @override
  Future<List<FBAuthor>> call(AuthorSearchData input) async {
    final List<FBAuthorResponse>  authorResponseList = await _authorApi.getList();
    if (authorResponseList.isNotEmpty && authorResponseList.first is FBErrorResponse) {
      return [];
    }
    final List<FBAuthor> authors = authorResponseList.map((e) => e.toEntity()).toList();
    return authors;
  }

}