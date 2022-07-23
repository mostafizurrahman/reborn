
import 'package:reborn/feature/data_model/base/base_state.dart';
import 'package:reborn/feature/data_model/entity/service_entity.dart';

class RecentState extends CCBaseState {

}

class RecentShimmerState extends RecentState {

}

class CreateRecentState extends RecentState {

}

class TapRecentState extends RecentState {
  final ServiceEntity recentService;
  TapRecentState({required this.recentService});
}

class UpdateRecentState extends RecentState {

}

