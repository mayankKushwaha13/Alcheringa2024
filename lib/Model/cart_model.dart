import 'package:alcheringa/Common/DBHandler.dart';

class CartModel {
  final String name;
  final String size;
  final String price;
  final String type;
  final String imageUrl;
  final String count;

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
}
