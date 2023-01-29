


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/domain/firebase/usecase/get_summary_use_case.dart';
import 'package:reborn/feature/home/rx_firebase_bloc/firebase_data_states.dart';
import 'package:reborn/feature/track_list/track_list_page.dart';
import 'package:reborn/feature/widget/view_provider.dart';
import 'package:reborn/utility/app_theme_data.dart';

class CategoryTitleView extends StatelessWidget  {
  final RebornCategory category;
  final FirebaseDataState firebaseState;
  final Function(CategorySummary) onSummaryCreated;
  const CategoryTitleView({Key? key, required this.category, required this.firebaseState, required this.onSummaryCreated}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 8),
          child: ViewProvider.getCupertinoIcon(iconValue: category.logoData.toInt()),
        ),
        Text(category.title.en, style: CCAppTheme.txt2.copyWith(fontWeight: FontWeight.w800)),
        const Expanded(child: Divider(height: 2, color: Colors.black54,),),
        ..._addSeeMore(context),
      ],
    );
  }

  List<Widget> _addSeeMore(final BuildContext context) {
    final List<Widget> _widgets = [];

    if (category.seeMore) {
      final _seeMore = Material(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: Ink(
          height: 30,
          width: 70,
          child: InkWell(
            onTap: () {
              if (firebaseState is FirebaseDataReadyState) {
                final state = firebaseState as FirebaseDataReadyState;
                final useCase = GetSummaryUseCase(tracks: state.tracks, authors: state.authors);
                useCase(category).then(onSummaryCreated);
              }
            },
            child: Center(child: Text(category.seeMoreTitle.en, style: CCAppTheme.txt)),
          ),
        ),
      );
      _widgets.add(_seeMore);
      _widgets.add(const SizedBox(width: 8));
    }
    return _widgets;
  }

}