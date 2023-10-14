
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities.dart';

part 'localized_response.g.dart';

@JsonSerializable(createToJson: false)
class LocalizedResponse {
  final String? en;
  final String? ru;
  LocalizedResponse({required this.en, required this.ru});

  factory LocalizedResponse.fromJson(Map<String, dynamic> json) =>
      _$LocalizedResponseFromJson(json);

  Map<String, dynamic> toJson() => {};

  LocalizedText toEntity() => LocalizedText(en: en ?? '', ru: ru ?? '');
}