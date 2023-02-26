import 'package:flutter/cupertino.dart';
import 'package:reborn/feature/domain/firebase/entities/reborn_category.dart';
import 'package:reborn/feature/ui/home/widgets/reborn_category_view.dart';
import 'package:reborn/feature/ui/filtering/reborn_filter_view.dart';
import 'package:reborn/utility/screen_data.dart';

class CategoryListView extends StatelessWidget {
  final List<RebornCategory> categories;
  const CategoryListView({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: HorizontalScrollBehavior(),
      child: ListView.builder(
        itemBuilder: _getCategoryView,
        itemCount: categories.length + 1,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
      ),
    );
  }

  Widget _getCategoryView(final BuildContext listContext, final int index) {
    if (index == 0) {
      return const RebornFilterView();
    }
    final RebornCategory category = categories[index - 1];
    final padding =
        screenData.getHomeVerticalPadding(categories.length, index - 1);


    return Padding(
      padding: padding,
      child: RebornCategoryView(
        category: category,
      ),
    );
  }
}
