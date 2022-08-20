import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class CCBaseEvent extends Equatable {
  final List properties;
  const CCBaseEvent([this.properties = const []]);
  @override
  List<Object> get props => [properties];
}