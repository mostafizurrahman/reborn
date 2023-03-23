import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/screen_data.dart';

class StatusCard extends StatelessWidget {
  final RebornSubscription subscription;
  const StatusCard({Key? key, required this.subscription}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final review = LocalizedText(
        en: 'Loved by 9 million people', ru: 'Любят 9 миллионов человек');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 24),
            _getBoxItem(),
            SizedBox(width: 12),
            _getDownloadBox(),
            SizedBox(height: 24),
          ],
        ),
        SizedBox(height: 48),
        Text(review.en),
        SizedBox(height: 12),
        SizedBox(
          width: screenData.width,
          height: 250,
          child: ListView.builder(
            itemBuilder: _getReviewListItem,
            itemCount: subscription.feedback.length,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _getReviewListItem(BuildContext ctx, int index) {
    final feedback = subscription.feedback[index];
    return Padding(
      padding: EdgeInsets.only(
          left: 24,
          right: index == subscription.feedback.length - 1 ? 24 : 0,
          top: 12,
          bottom: 12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        width: screenData.width * 0.6,
        decoration: CCAppTheme.shadowNoBorder.copyWith(boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(100),
            spreadRadius: 3,
            blurRadius: 9,
          )
        ]),
        child: Column(
          children: [
            SizedBox(height: 8),
            Row(children: List.generate(5, getStar)),

            Expanded(
                child: Text(
              feedback.review.en,
              style: CCAppTheme.txt
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 13.6),
            ),),
            SizedBox(height: 8),
            Row(
              
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: feedback.image,
                      errorWidget: (_, __, ___) => Icon(Icons.person),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                // Expanded(
                //   child: SizedBox(
                //     // width: screenData.width - 120,
                //     height: 120,
                Expanded(child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(feedback.name.en),
                    Text(feedback.title.en, style: CCAppTheme.txt,),
                  ],
                )),            SizedBox(width: 12),
                //   ),
                // )
              ],
            ),

            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _getBoxItem() {
    final appStore =
        LocalizedText(en: 'App Store Review', ru: 'Обзор магазина приложений');
    final playStore =
        LocalizedText(en: 'Play Store Review', ru: 'Обзор игрового магазина');
    return Container(
      decoration: CCAppTheme.shadowNoBorder.copyWith(boxShadow: [
        BoxShadow(
          color: Colors.grey.withAlpha(100),
          spreadRadius: 8,
          blurRadius: 16,
        )
      ]),
      child: Column(
        children: [
          SizedBox(height: 24),
          Icon(CupertinoIcons.heart_fill, color: Colors.redAccent),
          Row(children: List.generate(5, getStar)),
          Text('5 Stars'),
          Text(Platform.isIOS ? appStore.en : playStore.en),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _getDownloadBox() {
    final download = LocalizedText(en: 'Download', ru: 'Скачать');
    final count = Platform.isIOS
        ? subscription.appStoreDownloads
        : subscription.playStoreDownloads;
    return Container(
      decoration: CCAppTheme.shadowNoBorder.copyWith(boxShadow: [
        BoxShadow(
          color: Colors.grey.withAlpha(100),
          spreadRadius: 8,
          blurRadius: 16,
        )
      ]),
      child: Column(
        children: [
          SizedBox(height: 24),
          Icon(CupertinoIcons.group, color: Colors.green),
          Row(children: List.generate(5, _getEmptyTxt)),
          Text(count),
          Text(download.en),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget getStar(final int index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Icon(
          CupertinoIcons.star_fill,
          color: Colors.yellow.shade600,
        ),
      );

  Widget _getEmptyTxt(final int index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Icon(
          CupertinoIcons.star_fill,
          color: Colors.transparent,
        ),
      );
}
