


class AppConfig {
  final String appStoreUrl;
  final String appVersion;
  final String playStoreUrl;
  final String privacyUrl;
  final String termsUrl;
  final bool forceUpdate;
  final int versionCode;

  AppConfig({
    required this.appStoreUrl,
    required this.appVersion,
    required this.playStoreUrl,
    required this.privacyUrl,
    required this.forceUpdate,
    required this.termsUrl,
    required this.versionCode,
  });
}