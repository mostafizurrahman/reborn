import 'package:flutter/material.dart';

class ServiceEntity<T> {
  final String serviceName;
  final String serviceDescription;
  final String imageUrl;
  final IconData iconData;
  final String topImageUrl; //if view has splits
  final String coreData; // mobile number, address etc
  final T serviceData;
  ServiceEntity(
      {required this.serviceName,
      required this.serviceDescription,
      this.imageUrl = "",
      this.iconData = Icons.star,
      this.topImageUrl = "",
      required this.coreData,
      required this.serviceData});
}
