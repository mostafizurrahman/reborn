import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/screen_data.dart';

class SubscriptionView extends StatelessWidget {
  final String due;
  final String price;
  const SubscriptionView({
    Key? key,
    required this.due,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalDue = LocalizedText(
        en: 'Total due today : $due', ru: 'Total due today: $due');
    const instruction = LocalizedText(
      en: 'You won\'t be charged until after your free trial.',
      ru: 'You won\'t be charged until after your free trial.',
    );
    final forget = LocalizedText(
        en: 'What if I forget to cancel?', ru: 'What if I forget to cancel?');
    return Material(
      color: Colors.transparent,
      shadowColor: Colors.greenAccent,
      borderRadius: BorderRadius.all(Radius.circular(8)),
      child: Column(
        children: [
          Text(totalDue.txt),
          Text(instruction.txt),
          SizedBox(height: 36),
          _getSubscriptionButton(context),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Ink(
              decoration: CCAppTheme.shadowNoBorder,
              child: InkWell(
                onTap: (){

                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(forget.txt),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getSubscriptionButton(context) {
    const trial = LocalizedText(en: 'Start Free Trial', ru: 'Начать бесплатную пробную версию');
    final priceTxt = LocalizedText(
      en: 'Try 7-days for free, then $price',
      ru: 'TПопробуйте 7 дней бесплатно, затем $price',
    );
    final monthPrice =
        const LocalizedText(en: '(Only \$4.99/mo)', ru: '(Только \$4.99/mo)');
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      // color: Colors.white,
      child: Container(
        width: screenData.width,
        decoration: CCAppTheme.subscriptionDecoration.copyWith(color: Colors.white),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          onTap: () {
            debugPrint('I am done');
          },
          // child: Text('done'),
          child: Column(
            children: [
              SizedBox(height: 24),
              Text(trial.txt),
              SizedBox(height: 8),
              Text(priceTxt.txt),
              SizedBox(height: 8),
              Text(monthPrice.txt),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
      // child: Ink(
      //
      //   decoration: CCAppTheme.shadowNoBorder,
      //
      // ),
    );
  }
}
