import 'package:json_annotation/json_annotation.dart';
import 'package:reborn/feature/data/network/firebase_api.dart';
import 'package:reborn/feature/domain/firebase/entities/app_config.dart';
part 'fb_config_response.g.dart';

@JsonSerializable(createToJson: false)
class FBConfigResponse extends BaseResponse{

  final String? appStoreUrl;
  final String? appVersion;
  final String? playStoreUrl;
  final String? privacyUrl;
  final String? termsUrl;
  final bool? forceUpdate;
  final int? versionCode;

  FBConfigResponse({
    required this.appStoreUrl,
    required this.appVersion,
    required this.playStoreUrl,
    required this.privacyUrl,
    required this.forceUpdate,
    required this.termsUrl,
    required this.versionCode,
  });

  factory FBConfigResponse.fromJson(Map<String, dynamic> json) => _$FBConfigResponseFromJson(json);

  Map<String, dynamic> toJson() => {};

  AppConfig toEntity() => AppConfig(
        appStoreUrl: appStoreUrl ?? '',
        appVersion: appVersion ?? '',
        playStoreUrl: playStoreUrl ?? '',
        forceUpdate: forceUpdate ?? false,
        versionCode: versionCode ?? 0,
        privacyUrl: privacyUrl ?? '',
        termsUrl: termsUrl ?? '',
      );
}
