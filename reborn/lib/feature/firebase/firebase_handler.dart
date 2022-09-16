import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reborn/feature/data/models/firebase/fb_author_response.dart';
import 'package:reborn/feature/data/models/firebase/fb_category_response.dart';
import 'package:reborn/feature/data/models/firebase/fb_config_response.dart';
import 'package:reborn/feature/data/models/firebase/fb_user_response.dart';
import 'package:reborn/feature/data/network/firebase_api.dart';
import 'package:rxdart/rxdart.dart';

import '../data/models/firebase/fb_error_response.dart';
import '../data/models/firebase/fb_track_response.dart';

part 'firebase_reader.dart';
part 'firebase_writer.dart';

class FirebaseHandler {
  final _firebaseStore = FirebaseFirestore.instance;
  final PublishSubject _dataPublisher = PublishSubject();
  PublishSubject get dataPublisher => _data._dataPublisher;
  static final _data = FirebaseHandler._internal();
  late final _FirebaseReader reader;
  FirebaseHandler._internal();
  final List<StreamSubscription<QuerySnapshot>> listenerList = [];
  factory FirebaseHandler() {
    _data.reader = _FirebaseReader(_data._firebaseStore);
    _data._listenFirebase();
    return _data;
  }

  void dispose() {
    _data._dataPublisher.close();
    for (var element in listenerList) {
      element.cancel();
    }
  }

  void _listenFirebase() {
    final Map<String, Function(QuerySnapshot)> _collections = {
      "categories": _onCategoriesChanged,
      "config": _onCategoriesChanged,
      "users": _onUsersChanged,
      "authors": _onAuthorsChanged,
      "tracks": _onTrackAdded,
    };
    _collections.forEach((key, value) {
      final _categories = _firebaseStore.collection(key).snapshots().listen(value);
      _categories.onError(_onError);
      listenerList.add(_categories);
    });
  }

  void _onError(final dynamic _error) {
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
    debugPrint("hawa banke");
  }
}

final firebase = FirebaseHandler();