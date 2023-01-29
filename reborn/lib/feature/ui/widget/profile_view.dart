import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reborn/utility/app_theme_data.dart';

class ProfileView extends StatelessWidget {
  final String imagePath;
  final Widget? content;
  final VoidCallback? onTap;
  final bool isCircular;
  final double dimension;
  const ProfileView({
    Key? key,
    required this.imagePath,
    this.dimension = 50,
    this.isCircular = true,
    this.content,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _onTap = onTap;
    return Container(
      decoration: CCAppTheme.circleBorderDec,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(dimension / 2)),
        child: Ink(
          width: dimension,
          height: dimension,
          child: InkWell(
            onTap: _onTap,
            child: CachedNetworkImage(
              imageUrl: imagePath,
              height: dimension,
              width: dimension,
              fit: BoxFit.contain,
              errorWidget: (_, __, ___) => const Icon(
                CupertinoIcons.person,
                size: 60,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
