import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/image_ext.dart';
import 'package:reborn/utility/screen_data.dart';

class SubscriptionTopBar extends StatelessWidget {
  const SubscriptionTopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
      width: screenData.width,
      height: 100,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.zero,
                child: Ink(
                  decoration: CCAppTheme.shadowNoBorder
                      .copyWith(borderRadius: BorderRadius.circular(40),
                  ),
                  width: 60,
                  height: 35,
                  child: InkWell(
                    child: const Center(
                      child: Text('  SKIP '),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              ),
              Expanded(
                child: Image(
                  image: ImageExt.getImageAsset('icon_circle_small.png'),
                  width: 60,
                  height: 60,
                ),
              ),
              const SizedBox(
                width: 72,
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            'REBORN SUBSCRIPTION',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
