import 'dart:math';

import 'package:flutter/cupertino.dart';
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
  static List<SecretTapType> get parentTypes =>
      [SecretTapType.tapParent, SecretTapType.tapParentPrivate];
  static List<SecretTapType> get secretTypes => [SecretTapType.tapParent, SecretTapType.tapRight];

  static String get idFavoriteContacts => "id_favorite_contacts";
  static String get idDeletedContacts => "recent_deleted_contacts";
  static String get idAdditionContacts => "recent_added_contacts";

  static List<TabBarData> getTabBarData(final Function(String) _onTabBarItemTap) => [
        TabBarData(
            iconData: Icons.star, tabID: "0_t_fav", name: "Favorite", onTap: _onTabBarItemTap)
          ..isSelected = false,
        TabBarData(
            iconData: Icons.timelapse, tabID: "1_t_recent", name: "Sleep", onTap: _onTabBarItemTap)
          ..isSelected = false,
        TabBarData(
            iconData: Icons.stream, tabID: "2_t_contact", name: "Reborn", onTap: _onTabBarItemTap)
          ..isSelected = true,
        TabBarData(
            iconData: Icons.account_circle_outlined,
            tabID: "3_t_qr",
            name: "Coaches",
            onTap: _onTabBarItemTap)
          ..isSelected = false,
        TabBarData(
            iconData: Icons.person_outline,
            tabID: "4_t_add",
            name: "Profile",
            onTap: _onTabBarItemTap)
          ..isSelected = false,
      ];

  static List<PageData> getPageData() {
    final _pageData0 = PageData(
        title: "LIVE & PEACE",
        imagePath: "startup/backup.jpg",
        iconPath: "reborn_circle.png",
        subTitle:
            "Feelings are much like waves, we can't stop them from coming but we can choose which ones to surf.");
    final _pageData1 = PageData(
        title: "INNER  PEACE",
        iconPath: "reborn_circle.png",
        imagePath: "startup/transfer.jpg",
        subTitle:
            "If you are depressed you are living in the past if you are anxious you are living in the future, if you are at peace, you are living in the present.");
    final _pageData2 = PageData(
        iconPath: "reborn_circle.png",
        title: "CONFIDENCE",
        imagePath: "startup/contacts.jpg",
        subTitle:
            "Self confidence is a super power. Once you start to believe in yourself, magic starts happening.");
    final _pageData3 = PageData(
        iconPath: "reborn_circle.png",
        title: "REBORN",
        imagePath: "startup/manager.jpg",
        subTitle:
            "Reborn yourself by living in peace, gaining your inner-self! Nothing remains as it was. If you know this, you can begin again, with pure joy in the uprooting");
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

  static List<SubFilterData> get subfilterList {
    return [
      SubFilterData(
          displayName: "Duration",
          subFilterID: "filter_duration_id",
          iconName: CupertinoIcons.timer),
      SubFilterData(
          displayName: "Coaches",
          subFilterID: "filter_coach_id",
          iconName: CupertinoIcons.rectangle_stack_person_crop),
      SubFilterData(
          displayName: "Gender", subFilterID: "filter_gender_id", iconName: Icons.person_outline),
      SubFilterData(
          displayName: "Country", subFilterID: "filter_country_id", iconName: Icons.flag_outlined),
    ];
  }

  static AudioAuthor get audioAuthor {
    return AudioAuthor(
        authorEmail: "abc@yahoo.com", authorName: "Katie Krimitsos", authorId: "xaya...r");
  }

  static RebornMeditationData get rebornMeditationData {
    return RebornMeditationData(
      audioAuthor: audioAuthor,
      meditationID: "meditation",
      meditationTitle: "Reborn yourself",
      duration: "4:29 Min",
      isPremiumContent: false,
      meditationCoverImage:
          "https://theproductivewoman.com/wp-content/uploads/2017/05/Katie-59c.jpg",
      meditationThumbImage:
          "https://4feo872yrq891mrmgs21v589-wpengine.netdna-ssl.com/wp-content/uploads/2022/03/Katie-Krimitsos2-scaled-e1646244833157.jpeg",
      meditationType: "Work Wellness",
    );
  }

  static List<RebornMeditationData> get rebornMeditationList {
    var rng = Random();
    return List.generate(2 + rng.nextInt(6), (index) => rebornMeditationData);
  }

  static RebornMeditation get rebornMeditation {
    return RebornMeditation(
      meditationID: "aasd_asd",
      authorList: [audioAuthor, audioAuthor],
      isPremiumMeditation: true,
      meditationList: rebornMeditationList,
    );
  }

  static List<MeditationCategoryData> get categoryList {
    var rng = Random();
    List<String> titles = [
      "Focus and Productivity",
      "Self Awareness at Work",
      "Deep Sleep Meditation",
      "Popular",
      "Made For Your"
    ];
    return List.generate(
        12,
        (index) => MeditationCategoryData(
            categoryID: "${index}_category",
            categoryTitle: titles[index % titles.length],
            rebornMeditationList: List.generate(2 + rng.nextInt(7), (index) => rebornMeditation),
            subFilterList: ["filter_gender_id", "filter_country_id", "filter_coach_id"]));
  }
}

class SubFilterData {
  final String subFilterID;
  final String displayName;
  final IconData iconName;
  SubFilterData({required this.subFilterID, required this.displayName, required this.iconName});
}

class ArgsKey {
  static String get secretType => "secret_type";
}

class MeditationCategoryData {
  final String categoryID;
  final String categoryTitle;
  final List<String> subFilterList; //subfilter_id
  final List<RebornMeditation> rebornMeditationList;
  MeditationCategoryData(

      {
        required this.categoryID,
      required this.categoryTitle,
      required this.subFilterList,
      required this.rebornMeditationList});
}

class RebornMeditation {
  final bool isPremiumMeditation;
  final String meditationID;
  final List<RebornMeditationData> meditationList;
  final List<AudioAuthor> authorList;



  RebornMeditation(
      {required this.meditationID,
      required this.meditationList,
      required this.authorList,
      required this.isPremiumMeditation});
}

class RebornMeditationData {
  final String meditationID;
  final String meditationTitle;
  final String meditationType;
  final String duration;
  final String meditationCoverImage;
  final String meditationThumbImage;

  final bool isPremiumContent;
  final AudioAuthor audioAuthor;
  RebornMeditationData(
      {required this.audioAuthor,
      required this.meditationID,
      required this.meditationTitle,
      required this.meditationType,
      required this.duration,
      required this.meditationCoverImage,
      required this.meditationThumbImage,
      required this.isPremiumContent});
}

class AudioAuthor {
  final String authorId;
  final String authorName;
  final String authorEmail;
  final String authorImage;
  final String authorDescription;
  final String authorQualification;
  final int authorAge;
  AudioAuthor(
      {required this.authorId,
      required this.authorName,
      required this.authorEmail,
      this.authorImage = "https://theproductivewoman.com/wp-content/uploads/2018/10/Katie-32.jpg",
      this.authorDescription =
          "Mama, Adventurer, Podcaster. Listen to daily guided meditation here 🎧👇🏽💗",
      this.authorQualification = "Creator of the Women’s Meditation Network.",
      this.authorAge = 39});
}
