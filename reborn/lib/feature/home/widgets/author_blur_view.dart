import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/widget/blur_round_view.dart';
import 'package:reborn/feature/widget/profile_view.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/screen_data.dart';

class AuthorBlurView extends StatelessWidget {
  final FBAuthor authorData;
  const AuthorBlurView({Key? key, required this.authorData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const Radius radius = Radius.circular(7);
    final Widget content = _getContent();
    return BlurRoundView(
      content: content,
      radius: const BorderRadius.only(bottomLeft: radius, bottomRight: radius),
    );
  }

  Widget _getContent() {
    final width = screenData.width * 0.5;
    return SizedBox(
      width: width,
      child: Row(
        children: [
          const SizedBox(width: 12),
          ProfileView(imagePath: authorData.profilePicture),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                Text("${authorData.firstName} ${authorData.lastName}", style: CCAppTheme.txtHL2,),
                const SizedBox(height: 8),
                Expanded(child: Text(authorData.biography.en, style: CCAppTheme.txt2.copyWith(color: Colors.white),),),
              ],
            ),
          )
        ],
      ),
    );
  }
}
