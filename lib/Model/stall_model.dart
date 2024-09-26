import 'package:google_maps_flutter/google_maps_flutter.dart';

class StallMenuItem {
  String name;
  double price;

  StallMenuItem({
    required this.name,
    required this.price,
  });

  factory StallMenuItem.fromMap(Map<String, dynamic> data) {
    return StallMenuItem(
      name: data['name'] ?? '',
      price: data['price']?.toDouble() ?? 0.0,
    );
  }
}

class StallModel {
  String name;
  String description;
  String imgUrl;
  List<StallMenuItem> menu;
  LatLng latLng;

  StallModel({
    required this.name,
    required this.description,
    required this.imgUrl,
    required this.menu,
    required this.latLng,
  });

  factory StallModel.fromMap(Map<String, dynamic> data) {
    var menuList = (data['menu'] as List<dynamic>?)
            ?.map((item) => StallMenuItem.fromMap(item as Map<String, dynamic>))
            .toList() ??
        [];

    return StallModel(
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imgUrl: data['imgUrl'] ?? '',
      menu: menuList,
      latLng: LatLng(
        (data['LatLng']?['latitude'] ?? 26.190750).toDouble(),
        (data['LatLng']?['longitude'] ?? 91.696418).toDouble(),
      ),
    );
  }
}
