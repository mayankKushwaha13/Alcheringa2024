import 'package:flutter/foundation.dart';

@immutable
class PassModel {
  final String id;
  final String name;

  const PassModel({
    required this.id,
    required this.name,
  });

  // Factory method to create a PassModel from a JSON map
  factory PassModel.fromJson(Map<String, dynamic> json) {
    return PassModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  // Method to convert PassModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
