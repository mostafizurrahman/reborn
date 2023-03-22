import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/feature/ui/subscription/rx_susbscription/subscriptio_states.dart';
import 'package:reborn/feature/ui/subscription/rx_susbscription/subscription_bloc.dart';
import 'package:reborn/feature/ui/subscription/rx_susbscription/subscriptoin_events.dart';
import 'package:reborn/utility/screen_data.dart';
import '../widget/loader/loading_view.dart';
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

  final subscriber = SubscriptionBloc();
  @override
  void initState() {
    super.initState();
    subscriber.add(GetSubscriptionDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    screenData.setScreenData(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder(
        bloc: subscriber,
        builder: _getSubscriptionContent,
      ),
    );
  }

  Widget _getSubscriptionContent(final BuildContext ctx, final SubscriptionState state) {
    if (state is SubscriptionLoadingState) {
      return defaultLoader;
    }
    return _getSubscriptionBody();
  }


  Widget _getSubscriptionBody() {
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
    return  SafeArea(
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
    );
  }
}
