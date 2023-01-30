import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/ui/author/author_details_page.dart';
import 'package:reborn/feature/ui/author/instructor_view.dart';
import 'package:reborn/feature/ui/author/rx_author/author_bloc.dart';
import 'package:reborn/feature/ui/author/rx_author/author_events.dart';
import 'package:reborn/feature/ui/author/rx_author/author_states.dart';
import 'package:reborn/utility/image_ext.dart';
import 'package:reborn/utility/screen_data.dart';

class AuthorListView extends StatefulWidget {
  const AuthorListView({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AuthorListState();
  }
}

class _AuthorListState extends State<AuthorListView> {
  final AuthorBloc authorBloc = AuthorBloc();
  @override
  void initState() {
    super.initState();
    authorBloc.add(GetAuthorListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: authorBloc,
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: screenData.width,
          height: double.maxFinite,
          child: BlocBuilder(
            builder: _getAuthorList,
            bloc: authorBloc,
          ),
        ),
      ),
    );
  }

  Widget _getAuthorList(final BuildContext ctx, final AuthorState state) {
    if (state is LoadAuthorListState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is GetAuthorListState) {
      final list = state.authors;
      return ListView.builder(
        itemBuilder: _getAuthorView,
        itemCount: list.length + 2,
      );
    }

    return const SizedBox();
  }

  Widget _getAuthorView(final BuildContext ctx, final int index) {
    if (index == 0) {
      return SizedBox(
        width: screenData.width,
        height: 75,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Image(
                image: ImageExt.getImageAsset("reborn_circle.png"),
                width: 40,),
            ),
            const Text(
              'REBORN COACHES',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            )
          ],
        ),
      );
    }
    final state = authorBloc.state as GetAuthorListState;
    if (state.authors.length == index - 1) {
      return const SizedBox(height: 100);
    }
    final author = state.authors[index - 1];
    return InstructorView(author: author, onTapAuthor: _onTapAuthor);
  }

  Route _onTapAuthor(final RebornAuthor author) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => AuthorDetailsPage(author: author),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void dispose() {
    authorBloc.close();
    super.dispose();
  }
}
