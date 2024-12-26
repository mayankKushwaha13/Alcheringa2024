import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String title;
  final String body;
  final DateTime time;

  NotificationModel(
      {required this.title, required this.body, required this.time});


  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      title: map['title'] ?? 'No Title',
      body: map['body'] ?? 'No Body',
      time: (map['time'] as Timestamp)
          .toDate(),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'time': Timestamp.fromDate(time), // Convert DateTime to Firestore Timestamp
    };
  }
}