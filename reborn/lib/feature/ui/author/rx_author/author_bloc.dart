

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/domain/firebase/usecase/get_author_use_case.dart';
import 'package:reborn/feature/ui/author/rx_author/author_events.dart';
import 'package:reborn/feature/ui/author/rx_author/author_states.dart';

class AuthorBloc extends Bloc<AuthorEvent, AuthorState> {

  AuthorBloc() : super(LoadAuthorListState()) {
    on<GetAuthorListEvent>(_getAuthorList);
  }

  Future<void> _getAuthorList(
      final GetAuthorListEvent event, final Emitter<AuthorState> emit) async {
    emit(LoadAuthorListState());
    final authorsUseCase = GetAuthorUseCase();
    final authors = await authorsUseCase(AuthorSearchData());
    emit(GetAuthorListState(authors: authors));
  }
}