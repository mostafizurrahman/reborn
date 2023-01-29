



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/feature/data_model/base/base_event.dart';
import 'package:reborn/feature/data_model/base/base_state.dart';
class LoadingEvent extends CCBaseEvent {

}

class StartLoading extends LoadingEvent {
  final bool shouldDismiss;
  StartLoading({this.shouldDismiss = false});
}

class EndLoading extends LoadingEvent {

}

class LoadingState extends CCBaseState {
  final bool shouldDismiss;
  LoadingState({ required this.shouldDismiss});
}

class LoadingStartState extends LoadingState {
  LoadingStartState({ required bool dismiss}) : super(shouldDismiss: dismiss);
}


class LoadingEndState extends LoadingState {
  LoadingEndState({ required bool dismiss}) : super(shouldDismiss: dismiss);
}

class LoadingErrorState extends LoadingState {
  final String errorText;
  LoadingErrorState({required bool dismiss, this.errorText = ""}) : super(shouldDismiss: dismiss);
}

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  static final _loader = LoadingBloc._internal();
  factory LoadingBloc() {
    return _loader;
  }
  LoadingBloc._internal(): super(LoadingState(shouldDismiss: false)) {
    on<StartLoading>((event, emit) => emit(LoadingStartState(dismiss: event.shouldDismiss)));
    on<EndLoading>(_onEndLoading);
  }

  void _onEndLoading(
      final EndLoading event, final Emitter<LoadingState> emit) async {

  }
}

final LoadingBloc loadingBloc = LoadingBloc();