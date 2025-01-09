// View Model
import 'package:flutter/cupertino.dart';

import '../Model/event_with_live.dart';

class ScheduleViewModel extends ChangeNotifier {
  List<EventWithLive> dayEvents0 = [];
  List<EventWithLive> dayEvents1 = [];
  List<EventWithLive> dayEvents2 = [];
  List<EventWithLive> dayEvents3 = [];

  final Map<String, List<String>> itemListMap = {
    "All": [
      "Lecture Hall 1",
      "Lecture Hall 2",
      "Lecture Hall 3",
      "Lecture Hall 4",
      "Core 5",
      "Core 1",
      "Front of Graffiti Wall",
      "Behind Graffiti Wall",
      "Old Sac Wall",
      "New SAC",
      "Old Sac Stage",
      "Conference Hall 1",
      "Conference Hall 2",
      "Conference Hall 3",
      "Conference Hall 4",
      "Mini Auditorium",
      "Auditorium",
      "Audi Park",
      "Senate Hall",
      "Rocko Stage",
      "Expo Stage",
      "Library",
      "Library Shed",
      "Library Basement",
      "Football Field",
      "Basketball Courts",
      "Volley Ball Court",
      "Pronite Stage",
      "Athletics Field",
      "Entire Campus"
    ],
    "Lecture Halls": [
      "Lecture Hall 1",
      "Lecture Hall 2",
      "Lecture Hall 3",
      "Lecture Hall 4",
      "Core 5",
      "Core 1"
    ],
    "Grounds": [
      "Football Field",
      "Basketball Courts",
      "Volley Ball Court",
      "Pronite Stage",
      "Athletics Field"
    ],
    // Add other venue categories...
  };

  void updateEvents(List<EventWithLive> events) {
    dayEvents0 =
        events.where((e) => e.eventDetail.starttime.date == 7).toList();
    dayEvents1 =
        events.where((e) => e.eventDetail.starttime.date == 8).toList();
    dayEvents2 =
        events.where((e) => e.eventDetail.starttime.date == 9).toList();
    dayEvents3 =
        events.where((e) => e.eventDetail.starttime.date == 10).toList();
    notifyListeners();
  }
}
