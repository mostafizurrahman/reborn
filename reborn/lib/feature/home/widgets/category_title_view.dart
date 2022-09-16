


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/widget/view_provider.dart';
import 'package:reborn/utility/app_theme_data.dart';

class CategoryTitleView extends StatelessWidget  {
  final RebornCategory category;
  const CategoryTitleView({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 8),
          child: ViewProvider.getCupertinoIcon(iconValue: category.logoData.toInt()),
        ),
        Text(category.title.en, style: CCAppTheme.txt2.copyWith(fontWeight: FontWeight.w800)),
        const Expanded(child: Divider(height: 2, color: Colors.black54,),),
        ..._addSeeMore(),
      ],
    );
  }

  List<Widget> _addSeeMore() {
    final List<Widget> _widgets = [];

    if (category.seeMore) {
      final _seeMore = Material(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: Ink(
          height: 30,
          width: 70,
          child: InkWell(
            onTap: (){
              //#ACTION VIEW ALL
              debugPrint("Ready for data");
            },
            child: Center(child: Text(category.seeMoreTitle.en, style: CCAppTheme.txt)),
          ),
        ),
      );
      _widgets.add(_seeMore);
      _widgets.add(const SizedBox(width: 8));
    }
    return _widgets;
  }

}