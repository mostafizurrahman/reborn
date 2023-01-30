

import 'dart:math';

import 'package:intl/intl.dart';






class DataFormatter{
  static String formattedDuration(Duration duration, {final bool shouldNewLine = false}) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours > 0) {
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds ${shouldNewLine? '\n' : ''}Hrs";
    }
    return "$twoDigitMinutes:$twoDigitSeconds  ${shouldNewLine? '\n' : ''}Min";
  }

  static String getFormatted({required final int number}) {
    double value = number.toDouble();
    if (value < 1000) {
      return number.toString();
    }
    if (value > 1000000) {
      return '${(value/1000000).toStringAsFixed(2)} M';
    }
    return '${(value/1000).toStringAsFixed(2)} K';
  }


  static List shuffle(List items) {
    var random = Random();

    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {

      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

  static String getStringDate(DateTime? dateTime) {
    if (dateTime == null) return "";
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static bool validateEmail(final String email){
    bool isEmailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+").hasMatch(email);

    return isEmailValid;
    // “^([\w.-]+)@([\w-]+)((.(\w){2,3})+)$“/
  }

  static bool validateUsername(final String username){
    return  RegExp(
      r"^([a-zA-Z0-9]{3,32})$",
      caseSensitive: false,
      multiLine: false,
    ).hasMatch(username);
  }
}


class WKey {

  static String get themeKey => "theme_key";
  static String get regDataKey => "registration_data";
  static String get resetUserNameKey => "reset_username";
  static String get uploadProfilePictureKey => "profile_picture_key";
  static String get loginAuthorizationKey => "authorization_key";
  static String get loginBirthDteKey => "date_birth_key";
  static String get loginMemberIdentifierKey => "member_id_key";
  static String get loginRefreshKey => "refresh_key";
  static String get uploadFeedVideoKey => "feed_video_key";
  static String get uploadVoiceRecordingKey => "voice_record_key";
  static String get symbolsKey => "symbol_list";
  static String get userNameKey => "user_name";
  static String get profileUrlKey => "profile_url";
  static String get feelingDateKey => "feelings_popup";
  static String get greetingYearKey => "birthday_greeting_year";
  static String get localeKey => "locale_code";
  static String get guardianLoggedInStatus => "is_guardian_logged_in";
}