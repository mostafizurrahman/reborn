



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/feature/data_model/base/base_state.dart';
import '../data_model/base/base_event.dart';
class LoadingEvent extends CCBaseEvent {

}

class StartLoading extends LoadingEvent {
  final bool shouldDismiss;
  StartLoading({this.shouldDismiss = false});
}

class EndLoading extends LoadingEvent {

}

class LoadingState extends CCBaseState {

}

class LoadingStartState extends LoadingState {
  final bool shouldDismiss;
  LoadingStartState({ required this.shouldDismiss});
}


class LoadingEndState extends LoadingState {

}

class LoadingErrorState extends LoadingState {
  final String errorText;
  LoadingErrorState({this.errorText = ""});
}

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc() : super(LoadingState()) {
    on<StartLoading>((event, emit) => emit(LoadingStartState(shouldDismiss: event.shouldDismiss)));
    on<EndLoading>(_onEndLoading);
  }

  void _onEndLoading(
      final EndLoading event, final Emitter<LoadingState> emit) async {

  }
}