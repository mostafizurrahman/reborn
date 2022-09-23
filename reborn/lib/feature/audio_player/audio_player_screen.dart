


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/feature/domain/entities.dart';

import '../widget/base_widget/theme_state.dart';

class AudioPlayerScreen extends StatefulWidget {
  final RebornCategory rebornCategory;
  const AudioPlayerScreen({Key? key, required this.rebornCategory}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _AudioPlayerState();
  }

  static const path = "/home/audio_player";
}

class _AudioPlayerState extends ThemeState<AudioPlayerScreen> {

  @override
  Widget build(BuildContext context) {

    return SizedBox();
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider<RebornFilterBloc>.value(value: _rebornNameBloc),
    //     BlocProvider<FirebaseDataBloc>.value(value: _firebaseBloc),
    //   ],
    //   child: BaseScaffoldState(
    //     floating: BottomNavigationView(tabBarBehaviour: _tabBehaviour),
    //     floatLocation: FloatingActionButtonLocation.centerDocked,
    //     drawer: const MenuWidget(),
    //     body: SafeArea(
    //       child: SizedBox(
    //         height: screenData.height,
    //         child: StreamBuilder<List<TabBarData>>(
    //           stream: _tabBehaviour.stream,
    //           builder: _onBuildTabView,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}