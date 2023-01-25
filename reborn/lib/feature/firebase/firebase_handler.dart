import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reborn/feature/data/models/firebase/fb_author_response.dart';
import 'package:reborn/feature/data/models/firebase/fb_category_response.dart';
import 'package:reborn/feature/data/models/firebase/fb_config_response.dart';
import 'package:reborn/feature/data/models/firebase/fb_user_response.dart';
import 'package:reborn/feature/data/network/firebase_api.dart';
import 'package:reborn/feature/data_model/sqlite_manager.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/utility/user_info.dart';
import 'package:rxdart/rxdart.dart';

import '../data/models/firebase/fb_error_response.dart';
import '../data/models/firebase/fb_track_response.dart';

part 'firebase_reader.dart';
part 'firebase_writer.dart';

final _setOption = SetOptions(merge: true);

class FirebaseHandler {
  final List<String> favoriteTracks = [];
  final _firebaseStore = FirebaseFirestore.instance;
  final PublishSubject _dataPublisher = PublishSubject();
  PublishSubject get dataPublisher => _data._dataPublisher;
  static final _data = FirebaseHandler._internal();
  late final _FirebaseReader reader;
  late final _FirebaseWriter writer;
  FirebaseHandler._internal();
  final List<StreamSubscription<QuerySnapshot>> listenerList = [];
  factory FirebaseHandler() {
    _data.reader = _FirebaseReader(_data._firebaseStore);
    _data.writer = _FirebaseWriter(_data._firebaseStore);
    return _data;
  }

  Future<bool> setFavorite(
      {required final TrackEntity trackEntity,
      required final String deviceID}) async {
    return await _data.writer._setFavoriteTrack(
      trackEntity,
      deviceID: deviceID,
      favoriteList: favoriteTracks,
    );
  }

  void dispose() {
    _data._dataPublisher.close();
    for (var element in listenerList) {
      element.cancel();
    }
  }

  void listenFirebase(final String deviceID) {
    _firebaseStore
        .collection(BaseApi.users)
        .doc(deviceID)
        .collection('favorites')
        .doc('tracks')
        .snapshots()
        .listen((event) {
          final data = event.data();
      debugPrint('${event.data()}');
      if (data != null) {
        final trackIdList = data['favorite_tracks'];
        if (trackIdList is List) {
          for(final id in trackIdList) {
            if (!favoriteTracks.contains(id)) {
              favoriteTracks.add(id.toString());
            }
          }
        }
      }
    });
  }

  void _onError(final dynamic error) {
    debugPrint("i am error");
  }

  void _onCategoriesChanged(final QuerySnapshot snapshot) {
    if (snapshot.docs.isNotEmpty) {
      for (final doc in snapshot.docs) {
        final data = doc.data();
        debugPrint("$data");
      }
    }
  }

  void _onUsersChanged(final QuerySnapshot snapshot) {
    if (snapshot.docs.isNotEmpty) {
      for (final doc in snapshot.docs) {
        final data = doc.data();
        debugPrint("$data");
      }
    }
  }

  void _onAuthorsChanged(final QuerySnapshot snapshot) {
    if (snapshot.docs.isNotEmpty) {
      for (final doc in snapshot.docs) {
        final data = doc.data();
        debugPrint("$data");
      }
    }
  }

  void _onTrackAdded(final QuerySnapshot snapshot) {
    if (snapshot.docs.isNotEmpty) {
      for (final doc in snapshot.docs) {
        final data = doc.data();
        debugPrint("$data");
      }
    }
  }

  void clearDB() {
    debugPrint("---");
  }
}

final firebase = FirebaseHandler();
