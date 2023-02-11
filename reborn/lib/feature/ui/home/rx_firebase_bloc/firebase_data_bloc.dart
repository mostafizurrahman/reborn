import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/feature/domain/firebase/entities/reborn_author.dart';
import 'package:reborn/feature/domain/firebase/entities/reborn_category.dart';
import 'package:reborn/feature/domain/firebase/entities/search_data.dart';
import 'package:reborn/feature/domain/firebase/entities/track_entity.dart';
import 'package:reborn/feature/domain/firebase/usecase/get_author_use_case.dart';
import 'package:reborn/feature/domain/firebase/usecase/get_category_use_case.dart';
import 'package:reborn/feature/domain/firebase/usecase/get_track_use_case.dart';
import 'package:reborn/feature/ui/home/rx_firebase_bloc/firebase_data_events.dart';
import 'package:reborn/feature/ui/home/rx_firebase_bloc/firebase_data_states.dart';
import 'package:reborn/utility/cache_storage.dart';

class FirebaseDataBloc extends Bloc<FirebaseDataEvent, FirebaseDataState> {
  FirebaseDataBloc() : super(FirebaseDataLoadingState()) {
    on<LoadFirebaseDataEvent>(_onLoadFirebaseData);
  }

  Future<void> _onLoadFirebaseData(
      final LoadFirebaseDataEvent event, final Emitter<FirebaseDataState> emit) async {
    emit(FirebaseDataLoadingState());
    await Firebase.initializeApp();
    final CategorySearchData searchData = CategorySearchData();
    final categoryUseCase = GetCategoryUseCase();
    final List<RebornCategory> categoryList = await categoryUseCase(searchData);
    if (categoryList.isNotEmpty) {
      final TrackSearchData trackSearchData = TrackSearchData();
      final trackUseCase = GetTrackUseCase();
      final List<TrackEntity> trackList = await trackUseCase(trackSearchData);
      if (trackList.isNotEmpty) {
        cacheStorage.tracks = trackList;
        final authorSearch = AuthorSearchData();
        final authorUseCase = GetAuthorUseCase();
        final List<RebornAuthor> authorList = await authorUseCase(authorSearch);
        if (authorList.isNotEmpty) {
          cacheStorage.authors = authorList;
          final state = FirebaseDataReadyState(
            categories: categoryList,
            tracks: trackList,
            authors: authorList,
          );
          emit(state);
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
