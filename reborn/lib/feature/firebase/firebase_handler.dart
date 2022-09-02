import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

part 'firebase_reader.dart';
part 'firebase_writer.dart';

class FirebaseHandler {
  final _firebaseStore = FirebaseFirestore.instance;
  final PublishSubject _dataPublisher = PublishSubject();
  PublishSubject get dataPublisher => _data._dataPublisher;
  static final _data = FirebaseHandler._internal();
  FirebaseHandler._internal();
  final List<StreamSubscription<QuerySnapshot>> listenerList = [];
  factory FirebaseHandler() {

    return _data;
  }

  void dispose() {
    _data._dataPublisher.close();
    for (var element in listenerList) {
      element.cancel();
    }
  }

  void _listenFirebase() {
    final _categories =
        _firebaseStore.collection("categories").snapshots().listen(_onCategoriesChanged);
    _categories.onError(_onError);
    listenerList.add(_categories);
    final _config = _firebaseStore.collection("config").snapshots().listen(_onCategoriesChanged);
    _config.onError(_onError);
    listenerList.add(_config);
    final _users = _firebaseStore.collection("users").snapshots().listen(_onUsersChanged);
    _users.onError(_onError);
    listenerList.add(_users);
    final _auths = _firebaseStore.collection("authors").snapshots().listen(_onAuthorsChanged);
    _auths.onError(_onError);
    listenerList.add(_auths);
    final _tracks = _firebaseStore.collection("tracks").snapshots().listen(_onTrackAdded);
    _tracks.onError(_onError);
    listenerList.add(_tracks);
  }

  void _onError(final dynamic? _error) {
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
    _data._listenFirebase();
  }
}

final dataHandler = FirebaseHandler();
