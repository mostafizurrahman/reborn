import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/feature/home/rx_reborn_name/reborn_name_bloc.dart';
import 'package:reborn/feature/widget/ink_widget.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/image_ext.dart';
import 'package:reborn/utility/screen_data.dart';
import 'package:reborn/utility/user_info.dart';

class HomeRebornNameView extends StatefulWidget {

  const HomeRebornNameView({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return HomeRebornNameState();
  }
}

class HomeRebornNameState extends State<HomeRebornNameView>{

  @override
  Widget build(BuildContext context) {
    final height = screenData.height * 0.6;
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: screenData.width,
        height: height,
        child: Column(
          children: [
            SizedBox(
              height: height * 0.3,
              width: screenData.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: RIButton(
                        onTap: () => Scaffold.of(context).openDrawer(),
                        iconData: Icons.menu_rounded,
                        iconColor: CCAppTheme.pinkDarkColor,
                        dimension: 45,
                        radius: 45/2),
                  ),
                ],
              ),
            ),
            Container(
              decoration: CCAppTheme.shadowDec.copyWith(color: Colors.grey.withAlpha(120)),
              height: height * 0.2,
              child: Image(
                  image: ImageExt.getImageAsset("reborn_circle.png"),
                  width: screenData.width * 0.5),
            ),
            const SizedBox(height: 24),
            Text("Hi - ${userInfo.displayName}", style: CCAppTheme.txtHL1),
            const SizedBox(height: 12),
            Text("How are you feeling?", style: CCAppTheme.txtHL2),
            RIButton(onTap: (){
              final bloc = BlocProvider.of<RebornNameBloc>(context);
              //show dialog for set feelings...
            }, iconData: Icons.stream, radius: 30),
          ],
        ),
      ),
    );
  }
}
