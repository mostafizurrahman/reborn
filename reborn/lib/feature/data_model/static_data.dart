import 'package:reborn/feature/data_model/contact_service.dart';
import 'package:reborn/feature/data_model/entity/service_entity.dart';
import 'package:reborn/utility/app_enum.dart';
import 'package:flutter/material.dart';

import '../home/home_tab_widget.dart';
import 'entity/recent_entity.dart';

class PageData {
  final String title;
  final String subTitle;
  final String imagePath;
  final String iconPath;
  final String description;

  PageData(
      {required this.title,
      required this.iconPath,
      required this.subTitle,
      required this.imagePath,
      this.description = ""});
}

class StaticData {

  static List<SecretTapType> get parentTypes => [SecretTapType.tapParent, SecretTapType.tapParentPrivate];
  static List<SecretTapType> get secretTypes => [SecretTapType.tapParent, SecretTapType.tapRight];

  static String get idFavoriteContacts => "id_favorite_contacts";
  static String get idDeletedContacts => "recent_deleted_contacts";
  static String get idAdditionContacts => "recent_added_contacts";

  static List<TabBarData> getTabBarData(
          final Function(String) _onTabBarItemTap) =>
      [
        TabBarData(
            iconData: Icons.star,
            tabID: "0_t_fav",
            name: "Favorite",
            onTap: _onTabBarItemTap)
          ..isSelected = false,
        TabBarData(
            iconData: Icons.timelapse,
            tabID: "1_t_recent",
            name: "Recent",
            onTap: _onTabBarItemTap)
          ..isSelected = false,
        TabBarData(
            iconData: Icons.home,
            tabID: "2_t_contact",
            name: "Home",
            onTap: _onTabBarItemTap)
          ..isSelected = true,
        TabBarData(
            iconData: Icons.qr_code,
            tabID: "3_t_qr",
            name: "ScanQR",
            onTap: _onTabBarItemTap)
          ..isSelected = false,
        TabBarData(
            iconData: Icons.share_outlined,
            tabID: "4_t_add",
            name: "Transfer",
            onTap: _onTabBarItemTap)
          ..isSelected = false,
      ];

  static List<PageData> getPageData() {
    final _pageData0 = PageData(
        title: "SECRET  CONTACTS",
        imagePath: "startup/contacts.jpg",
        iconPath: "startup/contacts.png",
        subTitle:
            "You may want to keep some contacts private, so that they do not appear in the original phone contact list. We provide such contact privacy!");
    final _pageData1 = PageData(
        title: "SHARE  CONTACTS",
        iconPath: "startup/transfer.png",
        imagePath: "startup/transfer.jpg",
        subTitle:
            "Share contacts among your personal devices. You may send/receive contacts to other person as well.");
    final _pageData2 = PageData(
        iconPath: "startup/backup.png",
        title: "BACKUP  CONTACTS",
        imagePath: "startup/backup.jpg",
        subTitle:
            "Backup your contacts so that remain forever, even you changes you mobile phone! Just login and sync the backup from cloud storage!");
    final _pageData3 = PageData(
        iconPath: "startup/manager.png",
        title: "CONTACT  MANAGER",
        imagePath: "startup/manager.jpg",
        subTitle:
            "You are here because of the duplication contacts drive you crazy during an emergency! We are here to sort things easy for you. Recent saved contacts, remove, merge duplicates, favorites, many more options - explore yourself!");
    return [_pageData0, _pageData1, _pageData2, _pageData3];
  }

  static List<ServiceEntity> get recentList {
    final _contactAddedEntity = RecentEntity(
      serviceID: idAdditionContacts,
      displayOrder: 1,
      contactList: contactService.recentList.entries
          .map<dynamic>((e) => e.value)
          .toList(), //List<Contact>.from(contactService.recentList.values.map((e) => null)),
    );
    final ServiceEntity recentlyAdded = ServiceEntity<RecentEntity>(
      serviceName: "Recently Added Contacts",
      serviceDescription: "Find the recently added contact list",
      coreData: "_ has recently added contact",
      iconData: Icons.group_add,
      serviceData: _contactAddedEntity,
    );

    final _contactDeletedEntity = RecentEntity(
      serviceID: idDeletedContacts,
      displayOrder: 2,
      contactList: contactService
          .recentDeleteList, //List<Contact>.from(contactService.recentList.values.map((e) => null)),
    );
    final ServiceEntity serviceEntity = ServiceEntity<RecentEntity>(
      serviceName: "Recently Deleted Contacts",
      serviceDescription: "Find the recently deleted contact list",
      coreData: "_ has recently deleted contact, find more...",
      iconData: Icons.delete,
      serviceData: _contactDeletedEntity,
    );

    final _favoriteEntity = RecentEntity(
      serviceID: idFavoriteContacts,
      displayOrder: 0,
      contactList: contactService
          .recentDeleteList, //List<Contact>.from(contactService.recentList.values.map((e) => null)),
    );
    final ServiceEntity favoriteServiceEntity = ServiceEntity<RecentEntity>(
      serviceName: "Favorite Contacts",
      serviceDescription: "Find your preferred contact list",
      coreData: "01675876752 has recently added to your contact, find more...",
      iconData: Icons.favorite,
      serviceData: _favoriteEntity,
    );

    return [favoriteServiceEntity, recentlyAdded, serviceEntity];
  }
}

class ArgsKey {
  static String get secretType => "secret_type";

}
