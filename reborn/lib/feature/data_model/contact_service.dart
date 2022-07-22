


import 'dart:io';

import 'package:reborn/feature/data_model/sqlite_manager.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';

import 'static_data.dart';

class ContactService {
  static int get recentCount => 15;
  final List<Contact> contactList = [];
  final Map<int, Contact> recentList = {};
  final List<Contact> recentDeleteList = [];

  static final _info = ContactService._internal();
  ContactService._internal();
  factory ContactService() {
    return _info;
  }

  Future<List<Contact>> getContactList() async {
    if (contactList.isEmpty) {
      List<Contact> contacts = await ContactsService.getContacts();
      contactList.addAll(contacts);
      return contacts;
    }
    return contactList;
  }

  void setRecent({required final Contact contact}) {
    try {
      List<int> _idfList = recentList.keys.toList();
      _idfList.sort();
      final int _idf = _getIDF(contact) ;
      if (_idfList.isEmpty) {
        recentList[_idf] = contact;
      } else {
        for(int i = _idfList.length - 1; i >= 0; i--) {
          if (_idfList[i] < _idf) {
            if (recentList.length >= recentCount) {
              final keyID = _idfList.removeAt(0);
              recentList.remove(keyID);
            }
            recentList[_idf] = contact;
            break;
          }
        }
      }
    } catch(exception) {
      debugPrint("$exception");
    }
  }

  int _getIDF(final Contact contact) {
    if (Platform.isIOS) {
      String _id = contact.identifier?.split("-")[1] ?? "";
      final int maxID = int.tryParse(_id, radix: 16) ?? 0;
      return contact.creationTime ?? maxID;
    }
    final int maxID = int.tryParse(contact.identifier ?? "-1") ?? -1;
    return maxID;
  }

  Future<void> updateRecent({required final Contact contact, required final String id}) async {
    if (id == StaticData.idFavoriteContacts) {
      sqlDatabase.favoriteList.insert(0, contact);
      sqlDatabase.saveContact(contact: contact,isFavorite: true);
    } else if (id == StaticData.idDeletedContacts) {
      recentDeleteList.insert(0, contact);
    } else if (id == StaticData.idAdditionContacts) {
      recentList[_getIDF(contact)] = contact;
    }
  }
}

final ContactService contactService = ContactService();