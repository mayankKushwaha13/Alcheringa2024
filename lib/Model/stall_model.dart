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
  String imgurl;
  List<StallMenuItem> menu;
  LatLng latLng;
  List<String> category;

  StallModel({
    required this.name,
    required this.description,
    required this.imgurl,
    required this.menu,
    required this.latLng,
    required this.category
  });

  factory StallModel.fromMap(Map<String, dynamic> data) {
    var menuList = (data['menu'] as List<dynamic>?)
            ?.map((item) => StallMenuItem.fromMap(item as Map<String, dynamic>))
            .toList() ??
        [];

    return StallModel(
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imgurl: data['imgurl'] ?? '',
      menu: menuList,
      latLng: LatLng(
        (data['LatLng']?['latitude'] ?? 26.190750).toDouble(),
        (data['LatLng']?['longitude'] ?? 91.696418).toDouble(),
      ),
      category: (data['category'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList() ??
          [],
    );
  }
}
