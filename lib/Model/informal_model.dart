import 'package:cloud_firestore/cloud_firestore.dart';

class InformalModel {
  String name;
  GeoPoint location;
  String imgUrl;

  InformalModel({
    required this.name,
    required this.location,
    required this.imgUrl,
  });

  factory InformalModel.fromMap(Map<String, dynamic> data) {
    return InformalModel(
      name: data['name'] ?? '',
      location:
          data['location'] ?? GeoPoint(26.18938295597227, 91.69602130270817),
      imgUrl: data['imgUrl'] ?? '',
    );
  }
}
