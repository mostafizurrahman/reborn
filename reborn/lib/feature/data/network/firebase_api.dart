

import 'package:flutter/foundation.dart';
import 'package:reborn/feature/data/models/firebase/fb_author_response.dart';
import 'package:reborn/feature/data/models/firebase/fb_category_response.dart';
import 'package:reborn/feature/data/models/firebase/fb_config_response.dart';
import 'package:reborn/feature/data/models/firebase/fb_subscription_response.dart';
import 'package:reborn/feature/data/models/firebase/fb_track_response.dart';

import '../../firebase/firebase_handler.dart';
part 'fb_author_api.dart';
part 'fb_track_api.dart';
part 'fb_category_api.dart';
part 'fb_config_api.dart';
part 'fb_sleep_api.dart';
part 'fb_subscription_api.dart';


class BaseResponse {
}

abstract class BaseApi {
  static const String tracks = "tracks";
  static const String config = "config";
  static const String category = "categories";
  static const String author = "authors";
  static const String users = "users";
  static const String subscription = "subscription";
  static const String sleep = "sleep";

  final String _apiPath ;
  BaseApi(this._apiPath);
  Future<List<T>> _read<T extends BaseResponse>() async {
    return await firebase.reader.read<T>(collectionKey: _apiPath);
  }

  Future<List<BaseResponse>> getList();
}