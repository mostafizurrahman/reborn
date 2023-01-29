import 'package:reborn/utility/app_theme_data.dart';
import 'package:flutter/material.dart';

class IndexWidget extends StatelessWidget {
  final int index;
  final Function(int) onTap;
  final double dimension;
  final bool isSelected;
  const IndexWidget(
      {Key? key,
      required this.index,
      required this.onTap,
      this.dimension = 40,
      this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected ? Colors.pinkAccent : Colors.black.withOpacity(0.5);
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(dimension / 2)),
      child: Material(
        child: Ink(
          child: InkWell(
            focusColor: Colors.blue,
            splashColor: Colors.blueAccent,
            onTap: ()=>onTap(index),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: borderColor, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(dimension / 2)),
              ),
              width: dimension,
              height: dimension,
              child: Padding(
                padding: EdgeInsets.all(dimension * .15),
                child: Container(
                  width: dimension * 0.85,
                  height: dimension * 0.85,
                  decoration: CCAppTheme.shadowDec.copyWith(
                      color: isSelected ? Colors.blueAccent : Colors.black),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
