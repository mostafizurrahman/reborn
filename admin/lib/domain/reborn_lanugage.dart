


import 'package:rxdart/rxdart.dart';

class RebornLanguage {
  final BehaviorSubject<String> _behaviorSubject = BehaviorSubject.seeded('en');
  String get code => _behaviorSubject.valueOrNull ?? 'en';
  Stream get codeStream => _behaviorSubject.stream;
  set languageCode(final String code) {
    _behaviorSubject.sink.add(code);
  }

  static final RebornLanguage _singleton = RebornLanguage._internal();
  factory RebornLanguage() {
    return _singleton;
  }

  RebornLanguage._internal();
  bool get isEnglish => code == 'en';
  bool get isRussian => code == 'ru';
}

final RebornLanguage language = RebornLanguage();