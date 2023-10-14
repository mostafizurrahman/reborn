
import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:collection/collection.dart';
import '../data/models/firebase/fb_track_response.dart';
import '../domain/firebase/entities/reborn_author.dart';
import '../domain/firebase/entities/track_entity.dart';
import 'contact_service.dart';

class SQLiteManager {
  static String get _tableTracks => "tracks";
  static String get _tableAuthors => "authors"; //email and phones
  // static String get _tableAddress => "contact_address";
  // final List<Contact> contactList = [];
  // final List<Contact> favoriteList = [];
  // final List<Contact> secretList = [];
  // final List<Contact> privateList = [];
  // static int get emailType => 1;
  // static int get phoneType => 2;
  // static int get postalType => 3;

  late final Database database;
  static final _info = SQLiteManager._internal();
  SQLiteManager._internal();
  factory SQLiteManager() {
    return _info;
  }

  Future<void> createDatabase() async {
    final database = await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'reborn.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) async {
        // Run the CREATE TABLE statement on the database.
        await db.execute('CREATE TABLE $_tableTracks (id INTEGER PRIMARY KEY,'
            ' jsonContent TEXT NOT NULL, trackID TEXT NOT NULL)');
        await db.execute('CREATE TABLE $_tableAuthors (id INTEGER PRIMARY KEY,'
            ' jsonContent TEXT NOT NULL, authorID TEXT NOT NULL)');
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    _info.database = database;
  }

  Future<bool> saveFavorite(
      final Map<String, dynamic> data, final String trackID) async {
    final String jsonString = json.encode(data);
    final database = _info.database;
    final info = {'jsonContent': jsonString, 'trackID': trackID};
    final id = await database.insert(_tableTracks, info,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id == 1;
  }

  Future<bool> deleteFavorite( final String trackID) async {
    final database = _info.database;
    final id = await database.delete(_tableTracks, where: 'trackID = ?', whereArgs: [trackID]);
    return id == 1;
  }
  
  Future<List<TrackEntity>> getFavoriteList({required final List<RebornAuthor> authors}) async {
    final database = _info.database;
    final List<Map> jsonTracks = await database.query(_tableTracks);
    final List<TrackEntity> tracks = [];
    if (jsonTracks.isNotEmpty) {
      for(final jsonTrack in jsonTracks) {
        final jsonContent = jsonTrack['jsonContent'];
        final Map<String, dynamic> data = (json.decode(jsonContent) as Map).map(_castEntry);
        final track = FBTrackResponse.fromJson(data).toEntity();
        authors.firstWhereOrNull(track.setAuthor);
        tracks.add(track);
      }
    }
    return tracks;
  }

  MapEntry<String, dynamic> _castEntry(final dynamic key, final dynamic value) {
    return MapEntry<String, dynamic>(key.toString(), value);
  }

  // Future<void> updateContacts() async {
  //   final _contacts = await contactService.getContactList();
  //   final List<Contact> _contactList = [];
  //   _contactList.addAll(contactList);
  //   _contactList.addAll(secretList);
  //   await Future.forEach(_contacts, (contact) async {
  //     if (contact is Contact) {
  //       if (contact.displayName?.contains("Mostafizur") ?? false) {
  //         debugPrint("This is a number");
  //       }
  //       final data = _contactList.firstWhereOrNull(
  //           (element) => element.identifier == contact.identifier);
  //       if (data == null) {
  //         await saveContact(contact: contact);
  //         contact.creationTime = DateTime.now().microsecondsSinceEpoch;
  //       }
  //       contactService.setRecent(contact: data ?? contact);
  //     }
  //   });
  //   debugPrint("${contactService.recentList}");
  // }
  //
  // Future<void> finish() async {
  //   await _info._createDatabase();
  //   await _info.initContacts();
  //   await _info.updateContacts();
  //   debugPrint("initialization finished");
  // }
  //
  // Future<void> saveContact(
  //     {required final Contact contact,
  //     final bool isSecret = false,
  //     final bool isFavorite = false,
  //     final bool isPrivate = false}) async {
  //   if (isSecret && secretList.contains(contact)) {
  //     return;
  //   }
  //   final _map = Map<String, dynamic>.from(contact.toMap());
  //   _map["secret"] = isSecret;
  //   _map["favorite"] = !isSecret && isFavorite;
  //   _map["favorite"] = !isSecret && !isFavorite && isPrivate;
  //   if (_map.containsKey("avatar")) {
  //     final Uint8List? _avatar = _map.remove("avatar");
  //     if (_avatar != null && _avatar.isNotEmpty) {
  //       final String base64Avatar = base64.encode(_avatar);
  //       _map["avatar"] = base64Avatar;
  //     } else {
  //       _map["avatar"] = "";
  //     }
  //   }
  //   final _database = _info.database;
  //   final _emailList = List<Map>.from(_map.remove("emails") as List? ?? []);
  //   final _emails =
  //       _emailList.map((e) => Map<String, dynamic>.from(e)).toList();
  //   final _phoneList = List<Map>.from(_map.remove("phones") as List? ?? []);
  //   final _phones =
  //       _phoneList.map((e) => Map<String, dynamic>.from(e)).toList();
  //   final _postalList =
  //       List<Map>.from(_map.remove("postalAddresses") as List? ?? []);
  //   final _postal =
  //       _postalList.map((e) => Map<String, dynamic>.from(e)).toList();
  //   final int _date = DateTime.now().microsecondsSinceEpoch;
  //   _map["time"] = _date;
  //   final insertID = await _database.insert(_tableContact, _map,
  //       conflictAlgorithm: ConflictAlgorithm.replace);
  //   if (_emails.isNotEmpty) {
  //     _insertInfo(_emails, insertID, _tableInfo, emailType);
  //   }
  //   if (_phones.isNotEmpty) {
  //     _insertInfo(_phones, insertID, _tableInfo, phoneType);
  //   }
  //   if (_postal.isNotEmpty) {
  //     _insertInfo(_postal, insertID, _tableAddress, postalType);
  //   }
  //   if (isSecret) {
  //     secretList.add(contact);
  //   } else if (isFavorite) {
  //     favoriteList.add(contact);
  //   }
  // }
  //
  // Future<bool> removeSecret(
  //     {required final Contact contact,
  //     final SecretRemoveType removeType =
  //         SecretRemoveType.deleteSecret}) async {
  //   final bool isDeleted = removeType == SecretRemoveType.deleteSecret
  //       ? await removeContact(contact: contact)
  //       : await _updateSecrete(contact: contact, removeType: removeType);
  //   if (isDeleted) {
  //     secretList.removeWhere((element) => element == contact);
  //   }
  //   return isDeleted;
  // }
  //
  // Future<bool> _updateSecrete(
  //     {required final Contact contact,
  //     required final SecretRemoveType removeType}) async {
  //   final db = _info.database;
  //   const _where = "identifier = ?";
  //
  //   await db.update(_tableContact, {"secret": false},
  //       where: _where, whereArgs: [contact.identifier]);
  //   if (removeType == SecretRemoveType.globalContact) {
  //     await ContactsService.addContact(contact);
  //     contactList.add(contact);
  //     return true;
  //   } else if (removeType == SecretRemoveType.privateContact) {
  //     int count = await db.update(_tableContact, {"private": true},
  //         where: _where, whereArgs: [contact.identifier]);
  //     if (count > 0) {
  //       privateList.add(contact);
  //       return true;
  //     }
  //   } else if (removeType == SecretRemoveType.makeFavorite) {
  //     int count = await db.update(_tableContact, {"favorite": true},
  //         where: _where, whereArgs: [contact.identifier]);
  //     if (count > 0) {
  //       favoriteList.add(contact);
  //       contactList.add(contact);
  //       return true;
  //     }
  //   }
  //   return false;
  // }
  //
  // Future<bool> removeContact({required final Contact contact}) async {
  //   final db = _info.database;
  //   const _where = "identifier = ?";
  //   final _contact = await db.query(_tableContact,
  //       where: _where, whereArgs: [contact.identifier], limit: 1);
  //   final id = _contact.first["id"] as int?;
  //   if (id != null) {
  //     const whereClause = "id = ?";
  //     int deleteCount =
  //         await db.delete(_tableInfo, where: whereClause, whereArgs: [id]);
  //     debugPrint("info total deleted $deleteCount");
  //   }
  //   final deleteCount = await db
  //       .delete(_tableContact, where: _where, whereArgs: [contact.identifier]);
  //   debugPrint("contact total deleted $deleteCount");
  //   return deleteCount != 0;
  // }
  //
  // void _insertInfo(final List<Map<String, dynamic>> infoList,
  //     final int insertID, final String tableName, int type) async {
  //   final _database = _info.database;
  //   await Future.forEach(infoList, (info) async {
  //     if (info != null && info is Map<String, dynamic>) {
  //       info["contact_id"] = insertID;
  //       info["info_type"] = type;
  //       debugPrint("inserting $info");
  //       _database.insert(tableName, info,
  //           conflictAlgorithm: ConflictAlgorithm.replace);
  //     }
  //     debugPrint("end emails insertion");
  //   });
  // }
  //
  // Future<void> initContacts() async {
  //   final _database = _info.database;
  //   final List<Map> _rows = await _database.query(_tableContact);
  //   await Future.forEach(_rows, (_contact) async {
  //     if (_contact != null && _contact is Map) {
  //       final contact = Map<String, dynamic>.from(_contact);
  //       final int id = contact["id"];
  //       if (contact.containsKey("avatar")) {
  //         final data = contact.remove("avatar");
  //         final _baseAvatar = data.toString();
  //         if (_baseAvatar.isNotEmpty) {
  //           final int8List = base64Decode(_baseAvatar);
  //           contact["avatar"] = int8List;
  //         } else {
  //           contact["avatar"] = null;
  //         }
  //       }
  //       const _where = "info_type = ? AND contact_id = ?";
  //       final _emails = await _database
  //           .query(_tableInfo, where: _where, whereArgs: [emailType, id]);
  //       final _phones = await _database
  //           .query(_tableInfo, where: _where, whereArgs: [phoneType, id]);
  //       final _address = await _database
  //           .query(_tableAddress, where: _where, whereArgs: [postalType, id]);
  //       contact["emails"] = _emails;
  //       contact["phones"] = _phones;
  //       contact["postalAddresses"] = _address;
  //       final phoneContact = Contact.fromMap(contact);
  //       if (contact["secret"] == 1) {
  //         secretList.add(phoneContact);
  //       } else {
  //         if (contact["favorite"] == 1) {
  //           contactList.add(phoneContact);
  //           favoriteList.add(phoneContact);
  //         } else if (contact["private"] == 1) {
  //           privateList.add(phoneContact);
  //         } else {
  //           contactList.add(phoneContact);
  //         }
  //       }
  //     }
  //   });
  // }
  //
  // Future<List<Contact>> getRecentlyDeletedList() async {
  //   final _contactList = await contactService.getContactList();
  //   final _sqlContactList = List<Contact>.from(contactList);
  //   _sqlContactList.removeWhere((sqlContact) {
  //     return _contactList.firstWhereOrNull(
  //             (contact) => contact.identifier == sqlContact.identifier) !=
  //         null;
  //   });
  //   return _sqlContactList;
  // }
}

final sqlDatabase = SQLiteManager();
