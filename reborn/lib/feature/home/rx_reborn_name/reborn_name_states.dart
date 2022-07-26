import '../../data_model/base/base_state.dart';

class RebornNameState extends CCBaseState {

}


class SetRebornNameState extends RebornNameState {
  final String name;
  SetRebornNameState({required this.name});
}