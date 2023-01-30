


import 'package:flutter/material.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/ui/base_widget/base_scaffold_state.dart';

class AuthorDetailsPage extends StatefulWidget {

  final RebornAuthor author;
  const AuthorDetailsPage({Key? key, required this.author}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _AuthorDetailsState();
  }
}

class _AuthorDetailsState extends State<AuthorDetailsPage> {

  @override
  Widget build(BuildContext context) {

    return BaseScaffoldState(

      body: SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),

    );
  }
}