import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/feature/ui/favorites/rx_favorite/favorite_track_bloc.dart';
import 'package:reborn/feature/ui/favorites/rx_favorite/favorite_track_events.dart';
import 'package:reborn/feature/ui/favorites/rx_favorite/favorite_track_states.dart';
import 'favorite_list_view.dart';

class HomeFavoriteView extends StatefulWidget {
  static const String path = "/home/favorite";

  const HomeFavoriteView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeFavoriteState();
  }
}

class _HomeFavoriteState extends State<HomeFavoriteView> {
  final FavoriteTrackBloc _favoriteTrackBloc = FavoriteTrackBloc();

  @override
  void initState() {
    super.initState();
    _favoriteTrackBloc.add(GetFavoriteTracksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _favoriteTrackBloc,
      child: BlocBuilder(
        builder: _getFavoriteWidget,
        bloc: _favoriteTrackBloc,
      ),
    );
  }

  Widget _getFavoriteWidget(
    final BuildContext buildContext,
    final FavoriteTrackState state,
  ) {
    if (state is FavoriteTrackLoadingState) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is GetFavoriteTracksState) {
      return TrackListView(tracks: state.tracks);
    }
    return Container();
  }

  @override
  void dispose() {
    _favoriteTrackBloc.close();
    super.dispose();
  }
}
