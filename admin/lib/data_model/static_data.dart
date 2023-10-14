import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../domain/entities.dart';
import 'contact_service.dart';
import 'entity/recent_entity.dart';
import 'entity/service_entity.dart';

enum SVStatus {
  complete,
  incomplete,
  active,
}

class SVData {
  final int order;
  final IconData iconData;
  final double iconSize;
  final LocalizedText title;
  final LocalizedText description;
  final SVStatus status;
  SVData({
    required this.order,
    required this.iconData,
    required this.iconSize,
    this.status = SVStatus.complete,
    this.title = const LocalizedText(en: 'This is title', ru: 'This is title'),
    this.description = const LocalizedText(
      en: 'Your description or subtitle goes here. it should be some long',
      ru: 'Your description or subtitle goes here. it should be some long',
    ),
  });
}
class PageData {
  final String title;
  final String subTitle;
  final String imagePath;
  final String iconPath;
  final String description;

  PageData({
    required this.title,
    required this.iconPath,
    required this.subTitle,
    required this.imagePath,
    this.description = "",
  });
}

class TabBarData {
  late bool isSelected;
  final String name;
  final String tabID;
  final IconData iconData;
  final String? iconPath;
  final Function(String) onTap;
  TabBarData({
    required this.tabID,
    required this.name,
    required this.iconData,
    required this.onTap,
    this.iconPath,
  });
}

class StaticData {


  static String get idFavoriteContacts => "id_favorite_contacts";
  static String get idDeletedContacts => "recent_deleted_contacts";
  static String get idAdditionContacts => "recent_added_contacts";
  static String get tabFavorite => "0_t_fav";
  static String get tabSleeping => "1_sleep";
  static String get tabReborn => "2_reborn";
  static String get tabCoaches => "3_coaches";
  static String get tabProfile => "4_profile";

  static List<TabBarData> getTabBarData(
          final Function(String) onTabBarItemTap) =>
      [
        TabBarData(
          iconData: Icons.star,
          tabID: tabFavorite,
          name: "Favorite",
          onTap: onTabBarItemTap,
        )..isSelected = false,
        TabBarData(
          iconData: Icons.timelapse,
          tabID: tabSleeping,
          name: "Sleep",
          onTap: onTabBarItemTap,
        )..isSelected = false,
        TabBarData(
          iconData: CupertinoIcons.sun_haze_fill,
          tabID: tabReborn,
          name: "Reborn",
          onTap: onTabBarItemTap,
          iconPath: 'icon_circle_small.png',
        )..isSelected = true,
        TabBarData(
          iconData: Icons.account_circle_outlined,
          tabID: tabCoaches,
          name: "Coaches",
          onTap: onTabBarItemTap,
        )..isSelected = false,
        TabBarData(
          iconData: Icons.person_outline,
          tabID: tabProfile,
          name: "Profile",
          onTap: onTabBarItemTap,
        )..isSelected = false,
      ];

  static List<PageData> getPageData() {
    final pageData0 = PageData(
        title: "LIVE & PEACE",
        imagePath: "startup/backup.jpg",
        iconPath: "reborn_circle.png",
        subTitle:
            "Feelings are much like waves, we can't stop them from coming but we can choose which ones to surf.");
    final pageData1 = PageData(
        title: "INNER  PEACE",
        iconPath: "reborn_circle.png",
        imagePath: "startup/transfer.jpg",
        subTitle:
            "If you are depressed you are living in the past if you are anxious you are living in the future, if you are at peace, you are living in the present.");
    final pageData2 = PageData(
        iconPath: "reborn_circle.png",
        title: "CONFIDENCE",
        imagePath: "startup/contacts.jpg",
        subTitle:
            "Self confidence is a super power. Once you start to believe in yourself, magic starts happening.");
    final pageData3 = PageData(
        iconPath: "reborn_circle.png",
        title: "REBORN",
        imagePath: "startup/manager.jpg",
        subTitle:
            "Reborn yourself by living in peace, gaining your inner-self! Nothing remains as it was. If you know this, you can begin again, with pure joy in the uprooting");
    return [pageData0, pageData1, pageData2, pageData3];
  }

  static List<ServiceEntity> get recentList {
    final contactAddedEntity = RecentEntity(
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
      serviceData: contactAddedEntity,
    );

    final contactDeletedEntity = RecentEntity(
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
      serviceData: contactDeletedEntity,
    );

    final favoriteEntity = RecentEntity(
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
      serviceData: favoriteEntity,
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
          displayName: "Gender",
          subFilterID: "filter_gender_id",
          iconName: Icons.person_outline),
      SubFilterData(
          displayName: "Country",
          subFilterID: "filter_country_id",
          iconName: Icons.flag_outlined),
    ];
  }

  static AudioAuthor get audioAuthor {
    return AudioAuthor(
        authorEmail: "abc@yahoo.com",
        authorName: "Katie Krimitsos",
        authorId: "xayar");
  }

  static RebornMeditationData get rebornMeditationData {
    var rng = Random();
    final images = [
      "https://wallpaperaccess.com/full/5117569.jpg",
      "https://images.unsplash.com/photo-1609154767012-331529e7d73b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDh8fHxlbnwwfHx8fA%3D%3D&w=1000&q=80",
      "https://media.istockphoto.com/photos/autumn-tree-picture-id474517002?k=20&m=474517002&s=612x612&w=0&h=K9GFM6NphMwPBe5C9cTDRwbfGhASH1M2FP6OsxoZMe4=",
      "https://media.istockphoto.com/photos/morning-in-the-field-picture-id184342766?b=1&k=20&m=184342766&s=170667a&w=0&h=a9LAA3eFjPgokvPQVmSttWOkP_6fCyNZlK2PQuh4rrw=",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQx25vr8cSjz7hb8AY1QExa6WTo1gLNPQmrICS8cqASaTbqX9gbRSMu6dGsIAUTqkKAY5Q&usqp=CAU"
    ];
    return RebornMeditationData(
      audioAuthor: audioAuthor,
      meditationID: "meditation",
      meditationTitle: "Reborn yourself",
      duration: "4:29 Min",
      isPremiumContent: false,
      meditationCoverImage: images[rng.nextInt(5)],
      meditationThumbImage:
          "https://theproductivewoman.com/wp-content/uploads/2017/05/Katie-59c.jpg",
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
                rebornMeditationList: List.generate(
                    2 + rng.nextInt(7), (index) => rebornMeditation),
                subFilterList: [
                  "filter_gender_id",
                  "filter_country_id",
                  "filter_coach_id"
                ]));
  }

  static List<String> gridImages = [
    "https://i.imgur.com/whbe83G.jpg",
    "https://i.imgur.com/wXMqHQ2.jpg",
    "https://i.imgur.com/9CtCQO6.jpg",
    "https://i.imgur.com/j8fuLNM.jpg",
  ];

  static List<String> coverImages = [
    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg",
    "https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072821_1280.jpg",
    "https://cdn.pixabay.com/photo/2012/08/27/14/19/mountains-55067_1280.png",
    "https://cdn.pixabay.com/photo/2016/12/11/12/02/mountains-1899264_1280.jpg",
  ];

  static List<SVData> getStatusItemList() {
    final items = [
      SVData(
        order: 0,
        iconData: CupertinoIcons.check_mark_circled,
        iconSize: 50,
        title: const LocalizedText(
          en: 'Install the app',
          ru: 'Установите приложение',
        ),
        description: const LocalizedText(
          en: 'You successfully created the signature',
          ru: 'Вы успешно создали подпись',
        ),
      ),
      SVData(
        order: 1,
        iconData: CupertinoIcons.check_mark_circled,
        iconSize: 50,
        title: const LocalizedText(
          en: 'Get Instant Access',
          ru: 'Получить мгновенный доступ',
        ),
        description: const LocalizedText(
          en: 'Start your full access to the premium contents',
          ru: 'Получите полный доступ к премиум-контенту',
        ),
      ),
      SVData(
        order: 2,
        iconData: CupertinoIcons.arrow_2_circlepath,
        iconSize: 50,
        status: SVStatus.active,
        title: const LocalizedText(
          en: 'Get 7 Days Free Trial',
          ru: 'Бесплатная пробная версия',
        ),
        description: const LocalizedText(
          en: 'Unlock all premium contents for 7 days free trial',
          ru: 'Разблокируйте весь премиальный контент на 7 дней бесплатной пробной версии',
        ),
      ),
      SVData(
        order: 3,
        iconData: CupertinoIcons.arrow_down_circle_fill,
        iconSize: 50,
        status: SVStatus.incomplete,
        title: const LocalizedText(
          en: 'Boost Your Mental Health',
          ru: 'Укрепите свое психическое здоровье',
        ),
        description: const LocalizedText(
          en: 'Sleep well, feel good! Become the master of your mind.',
          ru: 'Спи спокойно, чувствуй себя хорошо! Станьте хозяином своего ума.',
        ),
      ),
    ];
    return items;
  }
}

class SubFilterData {
  final String subFilterID;
  final String displayName;
  final IconData iconName;
  SubFilterData(
      {required this.subFilterID,
      required this.displayName,
      required this.iconName});
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
      {required this.categoryID,
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
      this.authorImage =
          "https://theproductivewoman.com/wp-content/uploads/2017/05/Katie-59c.jpg",
      this.authorDescription =
          "Mama, Adventurer, Podcaster. Listen to daily guided meditation here 🎧👇🏽💗",
      this.authorQualification = "Creator of the Women’s Meditation Network.",
      this.authorAge = 39});
}
