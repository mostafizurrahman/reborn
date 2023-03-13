import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reborn/utility/image_ext.dart';
import 'package:reborn/utility/screen_data.dart';

class SubscriptionTopBar extends StatelessWidget {
  const SubscriptionTopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenData.width,
      height: 81,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 0),
                child: Ink(
                  height: 50,
                  width: 50,
                  child: InkWell(
                    child: const Icon(
                      CupertinoIcons.arrow_left_circle,
                      color: Colors.black,
                      size: 35,
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Image(
                    image: ImageExt.getImageAsset('icon_circle_small.png'),
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
              const SizedBox(
                width: 62,
              ),
            ],
          ),
          SizedBox(height: 12,),
          Text('REBORN SUBSCRIPTION'),
        ],
      ),
    );
  }
}
