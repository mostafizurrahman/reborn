


import 'package:flutter/material.dart';
import 'package:reborn/feature/widget/base_widget/theme_state.dart';

import '../../domain/entities.dart';
import '../rx_firebase_bloc/firebase_data_states.dart';

class RebornCategoryView extends StatefulWidget {
  final FirebaseDataReadyState firebaseState;
  final FBCategory category;
  const RebornCategoryView({Key? key, required this.firebaseState, required this.category}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RebornCategoryState();
  }
}

class _RebornCategoryState extends ThemeState<RebornCategoryView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }

}