import 'package:reborn/feature/data_model/static_data.dart';
import 'package:reborn/feature/home/rx_recent/recent_bloc.dart';
import 'package:reborn/feature/home/rx_recent/recent_events.dart';
import 'package:flutter/material.dart';

import '../../utility/app_theme_data.dart';
import '../../utility/screen_data.dart';
import '../data_model/entity/service_entity.dart';
import '../widget/service_widget.dart';
import '../widget/widget_properties.dart';

class HomeRecentWidget extends StatelessWidget {
  final RecentBloc recentBloc;
  const HomeRecentWidget({Key? key, required this.recentBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serviceList = StaticData.recentList;
    final WidgetProperties properties =
        WidgetProperties(width: screenData.width * 0.85, height: 120);
    return SizedBox(
      height: 244,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 4),
              child: Text("RECENT ACTIVITIES", style: CCAppTheme.txtHL2),
            ),
            SizedBox(
              height: 185,
              width: screenData.width,
              child: ListView.builder(
                itemBuilder: (final _context, final _index) {
                  return Padding(
                    padding: _getPadding(serviceList.length, _index),
                    child: ServiceWidget(
                        properties: properties,
                        serviceEntity: serviceList[_index],
                        onTapped: _onTappedService),
                  );
                },
                itemCount: serviceList.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  EdgeInsets _getPadding(final int length, final int _index) {
    double left = 8, right = 8;
    if (_index == 0) {
      left = 16;
    } else if (_index == length - 1) {
      right = 16;
    }
    return EdgeInsets.only(top: 12, left: left, right: right, bottom: 12);
  }

  void _onTappedService(final ServiceEntity serviceEntity) {
    recentBloc.add(RecentTapEvent(service: serviceEntity));
  }
}
