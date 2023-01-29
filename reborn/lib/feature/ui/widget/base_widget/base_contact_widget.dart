


import 'package:reborn/feature/data_model/static_data.dart';
import 'package:reborn/utility/app_enum.dart';
import 'package:flutter/material.dart';




abstract class BaseContactWidget extends StatefulWidget {

  final Object? arguments;
  const BaseContactWidget({Key? key, required this.arguments}) : super(key: key);
  SecretTapType get secretType {
    final args = arguments as Map?;
    return args?[ArgsKey.secretType] as SecretTapType? ?? SecretTapType.noSecret;
  }

  bool get isSecretContact => StaticData.secretTypes.contains(secretType);

  dynamic? getData({required final String key}) {
    final map = arguments as Map?;
    return map?[key];
  }
}