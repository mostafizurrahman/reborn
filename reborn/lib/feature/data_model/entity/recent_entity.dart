import 'package:contacts_service/contacts_service.dart';

class RecentEntity {
  final String serviceID;
  final int displayOrder;
  final List<Contact> contactList;
  RecentEntity(
      {required this.serviceID,
      required this.displayOrder,
      required this.contactList});
}
