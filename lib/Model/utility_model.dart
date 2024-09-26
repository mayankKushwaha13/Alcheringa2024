import 'package:cloud_firestore/cloud_firestore.dart';

class UtilityModel {
  String name;
  String description;
  GeoPoint? location;
  String type;
  String link;
  String imgUrl;

  UtilityModel({
    required this.name,
    required this.description,
    this.location,
    required this.type,
    required this.link,
    required this.imgUrl,
  });

  factory UtilityModel.fromMap(Map<String, dynamic> data) {
    return UtilityModel(
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      location: data['location'],
      type: data['type'] ?? '',
      link: data['link'] ?? '',
      imgUrl: data['imgUrl'] ?? '',
    );
  }
}
