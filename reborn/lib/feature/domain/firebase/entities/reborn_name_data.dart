

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RebornNameData {
  final String userName;
  RebornNameData({required this.userName});
}


class RebornFilterData {
  final String filterID;
  final String displayName;
  final int displayOrder;
  final IconData? iconData;
  final String? iconPath;
  bool isSelected;
  RebornFilterData(
      {required this.filterID,
        required this.displayName,
        required this.displayOrder,
        this.iconData,
        this.iconPath,
        this.isSelected = false,
      });

  static List<RebornFilterData> generateGridData() {
    List<RebornFilterData> data = [];
    Map<String, IconData> _titles = {
      "Wellness": Icons.stream,
      "Meditation": Icons.center_focus_strong_outlined,
      "Sounds": Icons.speaker_outlined,
      "Story": Icons.description_outlined,
      "Coaching": Icons.leak_add_rounded,
      "Breathwork": Icons.healing,
      "Music": Icons.music_note_outlined,
      "ASMR": Icons.star,
      "Emotions": Icons.ac_unit_sharp,
      "Therapy": CupertinoIcons.brightness,
      "Programs": CupertinoIcons.square_stack_3d_down_right,
      "Hypnosis": CupertinoIcons.bed_double,
      "Stories": CupertinoIcons.book
    };
    int i = 0;
    _titles.forEach((key, value) {
      data.add(RebornFilterData(
        displayOrder: i++,
        filterID: "${key.toLowerCase()}_$i",
        displayName: key,
        iconData: value,
      ));
    });
    return data;
  }
}