import '../../data_model/base/base_event.dart';

class RebornNameEvent extends CCBaseEvent {

}


class SetRebornNameEvent extends RebornNameEvent {
  final String name;
  SetRebornNameEvent({required this.name});
}