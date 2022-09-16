import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/feature/data/network/firebase_api.dart';
import 'package:reborn/feature/domain/firebase/entities/track_entity.dart';
import 'package:reborn/feature/domain/firebase/usecase/get_author_use_case.dart';
import 'package:reborn/feature/domain/firebase/usecase/get_category_use_case.dart';
import 'package:reborn/feature/domain/firebase/usecase/get_track_use_case.dart';
import 'package:reborn/feature/home/rx_firebase_bloc/firebase_data_events.dart';
import 'package:reborn/feature/home/rx_firebase_bloc/firebase_data_states.dart';

import '../../domain/entities.dart';

class FirebaseDataBloc extends Bloc<FirebaseDataEvent, FirebaseDataState> {
  FirebaseDataBloc() : super(FirebaseDataLoadingState()) {
    on<LoadFirebaseDataEvent>(_onLoadFirebaseData);
    on<CompleteFirebaseDataEvent>(
      (event, emit) => emit(
        FirebaseDataReadyState(
          categories: event.categories,
          tracks: event.tracks,
          authors: event.authors,
        ),
      ),
    );
  }

  Future<void> _onLoadFirebaseData(
      final LoadFirebaseDataEvent event, final Emitter<FirebaseDataState> emit) async {
    emit(FirebaseDataLoadingState());
    final CategorySearchData searchData = CategorySearchData();
    final categoryUseCase = GetCategoryUseCase();
    final List<FBCategory> categoryList = await categoryUseCase(searchData);
    if (categoryList.isNotEmpty) {
      final TrackSearchData trackSearchData = TrackSearchData();
      final trackUseCase = GetTrackUseCase();
      final List<TrackEntity> trackList = await trackUseCase(trackSearchData);
      if (trackList.isNotEmpty) {
        final authorSearch = AuthorSearchData();
        final authorUseCase = GetAuthorUseCase();
        final List<FBAuthor> authorList = await authorUseCase(authorSearch);
        if (authorList.isNotEmpty) {
          final _event = CompleteFirebaseDataEvent(
            categories: categoryList,
            tracks: trackList,
            authors: authorList,
          );
          add(_event);
        } else {
          emit(FirebaseDataErrorState());
        }
      } else {
        emit(FirebaseDataErrorState());
      }
    } else {
      emit(FirebaseDataErrorState());
    }
  }
}
