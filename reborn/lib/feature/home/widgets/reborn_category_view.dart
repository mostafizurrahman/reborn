import 'package:flutter/material.dart';
import 'package:reborn/feature/widget/base_widget/theme_state.dart';
import 'package:reborn/utility/screen_data.dart';

import '../../domain/entities.dart';
import '../rx_firebase_bloc/firebase_data_states.dart';
import 'category_title_view.dart';

class RebornCategoryView extends StatefulWidget {
  final FirebaseDataReadyState firebaseState;
  final RebornCategory category;
  const RebornCategoryView({
    Key? key,
    required this.firebaseState,
    required this.category,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RebornCategoryState();
  }
}

class _RebornCategoryState extends State<RebornCategoryView> {
  @override
  Widget build(BuildContext context) {
    final double height = screenData.height * 0.225;

    return Container(
      height: height,
      width: screenData.width,
      child: Column(
        children: [
          Container(
            height: 50,
            child: CategoryTitleView(category: widget.category,),
          )
        ],
      ),
    );
  }
}
