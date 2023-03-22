import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reborn/utility/screen_data.dart';
import 'widget/status_content_view.dart';
import 'widget/subscription_top_bar.dart';
import 'widget/subscription_view.dart';
import 'widget/trial_title_view.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SubscriptionPageState();
  }
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  Widget build(BuildContext context) {
    screenData.setScreenData(context);
    final items = [
      SVData(
          order: 0, iconData: CupertinoIcons.check_mark_circled, iconSize: 50),
      SVData(
          order: 1, iconData: CupertinoIcons.check_mark_circled, iconSize: 50),
      SVData(
          order: 2,
          iconData: CupertinoIcons.arrow_2_circlepath,
          iconSize: 50,
          status: SVStatus.active),
      SVData(
          order: 3,
          iconData: CupertinoIcons.arrow_down_circle_fill,
          iconSize: 50,
          status: SVStatus.incomplete),
      SVData(
          order: 3,
          iconData: CupertinoIcons.arrow_down_circle_fill,
          iconSize: 50,
          status: SVStatus.incomplete),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child:  Column(
              children: [
                const SubscriptionTopBar(),
                SizedBox(height: 24),
                TrialTitleView(),
                StatusContentView(
                  verticleItems: items,
                  index: 2,
                ),
                SizedBox(height: 12),
                Divider(height: 2),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: SubscriptionView(due: '\$0.00',price: '\$4.99'),
                ),
                Divider(height: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
