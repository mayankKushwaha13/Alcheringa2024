import 'package:cloud_firestore/cloud_firestore.dart';

class MyOrder {
  final String name;
  final String type;
  final String size;
  final int price;
  final int count;
  final String image;
  final DateTime timestamp;
  final bool isDelivered;

  MyOrder({
    required this.name,
    required this.type,
    required this.size,
    required this.price,
    required this.count,
    required this.image,
    required this.timestamp,
    required this.isDelivered,
  });
  factory MyOrder.fromMap(Map<String, dynamic> map) {
    return MyOrder(
      name: map['Name'] ?? '',
      type: map['Type'] ?? '',
      size: map['Size'] ?? '',
      price: int.tryParse(map['Price'] ?? '0') ?? 0,
      count: int.tryParse(map['Count'] ?? '0') ?? 0,
      image: map['image'] ?? '',
      timestamp: (map['Timestamp'] as Timestamp).toDate(),
      isDelivered: map['isDelivered'] ?? false,
    );
  }
}
