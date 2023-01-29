import 'package:reborn/feature/data_model/base/base_event.dart';
import 'package:reborn/feature/data_model/entity/service_entity.dart';

class RecentEvent extends CCBaseEvent {

}


class RecentTapEvent extends RecentEvent {
  final ServiceEntity service;
  RecentTapEvent({required this.service});
}

class RecentUpdateEvent extends RecentEvent {
  final String recentID;
  final dynamic contact;
  RecentUpdateEvent({required this.recentID, required this.contact});
}

class RecentShimmerEvent extends RecentEvent {

}

