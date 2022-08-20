import 'package:flutter/material.dart';

class InkWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final Color tapColor;
  final double dimension;
  final double? height;
  final Widget content;
  const InkWidget(
      {Key? key,
      required this.content,
      required this.onTap,
      this.tapColor = Colors.grey,
      this.dimension = 55,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _height = height != null ? height! : dimension;

    return Material(
      color: Colors.transparent,
      child: Ink(
        child: InkWell(
          focusColor: Colors.blue,
          splashColor: Colors.blueAccent,
          onTap: onTap,
          child: SizedBox(
            width: dimension,
            height: _height,
            child: Center(child: content),
          ),
        ),
      ),
    );
  }
}

class CCImageButton extends CCIconButton {
  final Widget imageWidget;
  const CCImageButton(
      {Key? key, required VoidCallback onTap,
      required this.imageWidget,
      final String title = "",
      final bool isStacked = false,
      final bool isRowButton = false,
      final double dimension = 55,
      final double? height,
      iconColor = Colors.black})
      : super(key: key,
            onTap: onTap,
            iconData: null,
            title: title,
            isRowButton: isRowButton,
            isStacked: isStacked,
            dimension: dimension,
            height: height);

  @override
  Widget get iconWidget => imageWidget;
}

class CCIconButton extends StatelessWidget {
  final String title;
  final IconData? iconData;
  final bool isStacked;
  final double dimension;
  final Color iconColor;
  final VoidCallback onTap;
  final double? height;
  final bool isRowButton;
  const CCIconButton(
      {Key? key,
      required this.onTap,
      required this.iconData,
      this.title = "",
      this.isStacked = false,
      this.isRowButton = false,
      this.dimension = 50,
      this.height,
      this.iconColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWidget(
        content: _content, onTap: onTap, dimension: dimension, height: height);
  }

  Widget get iconWidget => Icon(
        iconData,
        color: iconColor,
        size: dimension * 0.75,
      );

  Widget get _content {
    if (isStacked) {
      return Stack(
        children: [
          iconWidget,
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Text(title, style: const TextStyle(fontFamily: "sf_light"),),
          )
        ],
      );
    }
    if (isRowButton) {
      return Row(
        children: [
          iconWidget,//Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: iconWidget),
          Center(child: Text(title, )),
        ],
      );
    }
    if (title.isNotEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(padding: const EdgeInsets.all(8), child: iconWidget),
          Center(child: Text(title,  style: const TextStyle(fontFamily: "sf_light"),)),
        ],
      );
    }
    return iconWidget;
  }
}

class RIButton extends CCIconButton {
  final double radius;

  const RIButton(
      {Key? key,
      required VoidCallback onTap,
      required IconData iconData,
      final Color iconColor = Colors.black,
      final double  dimension = 50,
      required this.radius})
      : super(key: key, onTap: onTap, iconData: iconData, iconColor: iconColor, dimension: dimension);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: super.build(context),
    );
  }
}
