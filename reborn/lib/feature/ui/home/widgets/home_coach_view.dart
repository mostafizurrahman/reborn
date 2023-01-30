

import 'package:flutter/material.dart';
import 'package:reborn/feature/ui/author/author_list_view.dart';
import 'package:reborn/utility/app_theme_data.dart';

class HomeCoachView extends StatefulWidget {
  static const String path = "/home/coach";

  const HomeCoachView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeCoachState();
  }
}

class _HomeCoachState extends State<HomeCoachView>  {

  @override
  Widget build(BuildContext context) {
    return AuthorListView();
  }
}