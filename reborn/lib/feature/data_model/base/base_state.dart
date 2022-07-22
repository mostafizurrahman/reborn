import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CCBaseState extends Equatable {
  final List properties;

  const CCBaseState([this.properties = const []]);
  @override
  List<Object?> get props => properties;
}
