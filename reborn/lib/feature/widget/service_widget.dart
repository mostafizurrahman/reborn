import 'dart:math';

import 'package:reborn/feature/data_model/entity/recent_entity.dart';
import 'package:reborn/feature/home/rx_recent/recent_events.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/image_ext.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../data_model/entity/service_entity.dart';
import 'widget_properties.dart';

class ServiceWidget extends StatelessWidget {
  final WidgetProperties properties;
  final ServiceEntity serviceEntity;
  final Function(ServiceEntity)? onTapped;
  const ServiceWidget(
      {Key? key,
      required this.properties,
      required this.serviceEntity,
      required this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _onTap = onTapped;
    return Container(
      decoration: CCAppTheme.shadowDec,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            focusColor: Colors.blue,
            splashColor: Colors.blueAccent,
            onTap: _onTap == null ? null : () => _onTap(serviceEntity),
            child: _innerWidget,
          ),
        ),
      ),
      width: properties.width,
      height: properties.height,
    );
  }

  Widget get _innerWidget {
    if (properties.isSplitWidget) {
      return Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Text(serviceEntity.serviceName, style: CCAppTheme.txtHL3),
                const SizedBox(height: 8),
                Text(serviceEntity.serviceDescription),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(100),
              // border: Border.all(color: Colors.pinkAccent.shade200, width: 2),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8.5),
                bottomRight: Radius.circular(8.5),
              ),
            ),
            width: properties.width,
            height: properties.topHeight,
            child: Column(
              children: [const Text("Top Widget")],
            ),
          ),
        ],
      );
    }
    final entity = serviceEntity.serviceData;
    return Container(
      color: Colors.transparent,
      width: properties.width,
      height: properties.bottomHeight ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
            child: Row(
              children: [
                Expanded(
                    child: Text(serviceEntity.serviceName,
                        style: CCAppTheme.txtHL3)),
                Icon(serviceEntity.iconData,
                    color: Colors.pinkAccent, size: 35),
                const SizedBox(width: 12),
              ],
            ),
          ),
          const Divider(height: 2),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(serviceEntity.serviceDescription, style: CCAppTheme.txt2),
                const SizedBox(height: 4),
                if (entity is RecentEntity && entity.contactList.isNotEmpty)
                  Text(
                      serviceEntity.coreData.replaceAll("_",
                          entity.contactList.first.phones?.first.value ?? ""),
                      style: CCAppTheme.txt)
              ],
            ),
          ),
          Expanded(child: const SizedBox()),
          if (serviceEntity.serviceData is RecentEntity)
            _getPictureRow(
                serviceEntity.serviceData, serviceEntity.serviceName),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _getPictureRow(final RecentEntity recentEntity, final String title) {
    if (recentEntity.contactList.isEmpty) {
      return SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Center(
            child: Text(
              "Add Some - $title",
              style: CCAppTheme.txt1.copyWith(
                  color: Colors.blueAccent, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }
    List<Widget> images = [];
    int index = 0;
    while (index < 5) {
      if (recentEntity.contactList.length < index) {
        final _data = recentEntity.contactList[index].avatar;
        if (_data != null) {
          final image = Image.memory(_data, width: 120, height: 120);
          images.add(image);
        } else {
          images.add(
            Icon(
              Icons.person_sharp,
              color: ImageExt.randomColor,
              size: 30,
            ),
          );
        }
      } else {
        images.add(Icon(
          Icons.person_sharp,
          color: ImageExt.randomColor,
          size: 30,
        ));
      }
      index++;
    }
    double pad = 12;
    return SizedBox(
      width: properties.width,
      height: 45,
      child: Stack(
        children: images.map((e) {
          final _widget = Positioned(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(120)),
              child: Container(
                width: 45,
                height: 45,
                decoration: CCAppTheme.shadowDec.copyWith(
                    borderRadius: const BorderRadius.all(Radius.circular(120)),
                    color: Colors.transparent),
                child: e,
              ),
            ),
            top: 0,
            bottom: 0,
            right: pad,
          );
          pad += 35;
          return _widget;
        }).toList(),
      ),
    );
  }

  BoxDecoration get _topBox => BoxDecoration(
        borderRadius: _topBorder,
        border: Border(
            left: borderSide,
            top: borderSide,
            right: borderSide,
            bottom: borderSide),
      );

  BoxDecoration get _bottomBox => BoxDecoration(
        borderRadius: _bottomBorder,
        border: Border(
            left: borderSide,
            top: borderSide,
            right: borderSide,
            bottom: borderSide.copyWith(color: Colors.red)),
      );

  BorderSide get borderSide => const BorderSide(
        //                   <--- left side
        color: Colors.black,
        width: 3.0,
      );

  BorderRadius get _topBorder => const BorderRadius.only(
      topLeft: Radius.circular(8), topRight: Radius.circular(8));

  BorderRadius get _bottomBorder => const BorderRadius.only(
      bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8));
}
