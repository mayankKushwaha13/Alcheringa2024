import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VenueModel {
  String name;
  LatLng latLng;
  String description;
  String imgUrl;

  VenueModel({
    required this.name,
    required this.latLng,
    required this.description,
    required this.imgUrl,
  });

  factory VenueModel.fromMap(Map<String, dynamic> data) {
    GeoPoint geoPoint = data['LatLng'] as GeoPoint;
    return VenueModel(
      name: data['name'] ?? 'Auditorium',
      latLng: LatLng(geoPoint.latitude, geoPoint.longitude),
      description: data['des'] ?? 'Click here to navigate',
      imgUrl: data['imgurl'] ?? '',
    );
  }
}
