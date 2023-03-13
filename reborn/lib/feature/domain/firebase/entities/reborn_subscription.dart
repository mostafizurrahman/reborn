import 'package:reborn/feature/domain/entities.dart';

class RebornFeedback {
  final String id;
  final String image;
  final String stars;
  final LocalizedText name;
  final LocalizedText title;
  final LocalizedText review;

  RebornFeedback({
    required this.id,
    required this.name,
    required this.title,
    required this.stars,
    required this.image,
    required this.review,
  });
}

class RebornSubscription {
  final String due;
  final String discount;
  final String subscription;
  final String reviewAppStore;
  final String reviewPlayStore;
  final List<LocalizedText> moto;
  final String appStoreDownloads;
  final String playStoreDownloads;
  final List<RebornFeedback> feedback;

  RebornSubscription({
    required this.due,
    required this.moto,
    required this.discount,
    required this.feedback,
    required this.subscription,
    required this.reviewAppStore,
    required this.reviewPlayStore,
    required this.appStoreDownloads,
    required this.playStoreDownloads,
  });
}
