
import 'package:reborn/feature/data_model/base/base_state.dart';
import 'package:reborn/feature/domain/firebase/entities/reborn_author.dart';

abstract class AuthorState extends CCBaseState {

}

class LoadAuthorListState extends AuthorState {

  @override
  String toString() {
    return 'LoadAuthorListState';
  }
}

class GetAuthorListState extends AuthorState {
  final List<RebornAuthor> authors;
  GetAuthorListState({required this.authors});

  @override
  String toString() {
    return 'GetAuthorListState';
  }
}

