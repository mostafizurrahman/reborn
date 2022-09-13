import 'dart:async';

import 'package:reborn/feature/data_model/static_data.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/image_ext.dart';
import 'package:reborn/utility/screen_data.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class WelcomePage extends StatefulWidget {
  final BehaviorSubject<int> pageBehaviour;
  const WelcomePage({Key? key, required this.pageBehaviour}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WelcomeState();
  }
}

class _WelcomeState extends State<WelcomePage> {
  final _pageController = PageController(initialPage: 0);
  late final StreamSubscription<int> _pagerSubscription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController.addListener(_onPageChanged);
    _pagerSubscription = widget.pageBehaviour.listen(_onPageIndexChanged);
  }
  
  void _onPageIndexChanged(final int index) {
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void _onPageChanged() {
    final page = _pageController.page;
    final int iPage = page?.toInt() ?? 0;
    if (iPage.toDouble() == page) {
      debugPrint("I am here");
      widget.pageBehaviour.sink.add(iPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<PageData> _pages = StaticData.getPageData();
    final _widgets =
        _pages.map((_pageData) => PageWidget(pageData: _pageData)).toList();
    return Material(
      color: Colors.white,
      child: PageView(
        controller: _pageController,
        children: _widgets,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    _pagerSubscription.cancel();
  }
}

class PageWidget extends StatelessWidget {
  final PageData pageData;
  const PageWidget({Key? key, required this.pageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: screenData.height * 0.75,
        decoration: CCAppTheme.shadowDec
            .copyWith(border: Border.all(color: Colors.white, width: 0)),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(pageData.title, style: CCAppTheme.txtHL1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Image(
                          image: ImageExt.getImageAsset(pageData.iconPath),
                          fit: BoxFit.fitWidth,
                          width: 50,
                          height: 50),
                    ),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(pageData.subTitle,
                    style: CCAppTheme.txt2, textAlign: TextAlign.left),
              ),
              Expanded(child: const SizedBox(), flex: 1),
              Image(
                  image: ImageExt.getImageAsset(pageData.imagePath),
                  fit: BoxFit.fitWidth)
            ],
          ),
        ),
      ),
    );
  }
}
