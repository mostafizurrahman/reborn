import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/domain/firebase/usecase/get_summary_use_case.dart';
import 'package:reborn/feature/ui/home/widgets/cubit/cubit_states.dart';

class SummaryCubit extends Cubit<CubitBaseState> {
  SummaryCubit() : super(CubitCategorySummarisingState());

  void emitCategorySummary(
    final List<TrackEntity> tracks,
    final List<RebornAuthor> authors,
    final RebornCategory category,
  ) async {
    final useCase = GetSummaryUseCase(tracks: tracks, authors: authors);
    final CategorySummary summary = await useCase(category);
    emit(CubitSummaryCategoryState(summary: summary));
  }
}
