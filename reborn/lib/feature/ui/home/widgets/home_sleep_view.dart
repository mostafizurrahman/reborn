import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/feature/domain/firebase/entities/reborn_category.dart';
import 'package:reborn/feature/ui/widget/category_list_view.dart';
import 'package:reborn/utility/app_theme_data.dart';

import '../../../domain/entities.dart';

class HomeSleepView extends StatefulWidget {
  static const String path = "/sleep-tab";
  final List<RebornCategory> categories;
  const HomeSleepView({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeSleepState();
  }
}

class _HomeSleepState extends State<HomeSleepView> {
  final filterList = RebornFilterData.generateGridData();
  final key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return CategoryListView(
      categories: widget.categories,
      key: GlobalKey(),
      filterList: filterList,
    );
  }
}
