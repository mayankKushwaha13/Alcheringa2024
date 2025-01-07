import 'package:alcheringa/Database/DBHandler.dart';

class CartModel {
  String name;
  String size;
  String price;
  String type;
  String imageUrl;
  String count;

  CartModel({
    required this.name,
    required this.size,
    required this.price,
    required this.type,
    required this.imageUrl,
    required this.count,
  });

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      name: map[DBHandler.nameCol],
      size: map[DBHandler.sizeCol],
      price: map[DBHandler.priceCol],
      type: map[DBHandler.typeCol],
      imageUrl: map[DBHandler.imageCol],
      count: map[DBHandler.countCol],
    );
  }
  // Method to convert CartModel to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'size': size,
      'count': count,
      'image': imageUrl,
      'type': type,
    };
  }
}
