


import 'package:reborn/feature/domain/category_summary.dart';

class CubitBaseState {
  const CubitBaseState();
}

class CubitCategorySummarisingState extends CubitBaseState {

}

class CubitSummaryCategoryState extends CubitBaseState {
  final CategorySummary summary;
  CubitSummaryCategoryState({required this.summary});
}

