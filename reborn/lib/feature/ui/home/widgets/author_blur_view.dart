
import 'package:flutter/material.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/ui/widget/blur_round_view.dart';
import 'package:reborn/feature/ui/widget/profile_view.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/screen_data.dart';

class AuthorLeftRoundView extends AuthorBlurView {
  const AuthorLeftRoundView({Key? key, required RebornAuthor authorData})
      : super(key: key, authorData: authorData);

  @override
  Widget build(BuildContext context) {
    const Radius radius = Radius.circular(40);
    final width = screenData.width * 0.5;
    final Widget content = SizedBox(
      width: width,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ProfileView(imagePath: authorData.profilePicture),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                Text(
                  "${authorData.firstName} ${authorData.lastName}",
                  style: CCAppTheme.txt2,
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: Text(
                    authorData.biography.txt,
                    style: CCAppTheme.txt.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return BlurRoundView(
        viewHeight:64,
      color: Colors.grey.withAlpha(100),
      content: content,
      radius: const BorderRadius.only(topLeft: radius, bottomLeft: radius, bottomRight:Radius.circular(12) ),
    );
  }
}

class AuthorBlurView extends StatelessWidget {
  final RebornAuthor authorData;
  final Color authorTitleColor;
  const AuthorBlurView({
    Key? key,
    required this.authorData,
    this.authorTitleColor = Colors.black,
  }) : super(key: key);
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
                Text(
                  "${authorData.firstName} ${authorData.lastName}",
                  style: CCAppTheme.txtReg.copyWith(
                    color: authorTitleColor,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Text(
                    authorData.biography.txt,
                    style: CCAppTheme.txt.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
