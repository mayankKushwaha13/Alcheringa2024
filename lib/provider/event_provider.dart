import 'package:alcheringa/Common/globals.dart';
import 'package:alcheringa/Model/eventdetail.dart';
import 'package:alcheringa/Model/view_model_main.dart';
import 'package:flutter/material.dart';

import '../Model/venue_model.dart';

class EventProvider with ChangeNotifier {
  List<EventDetail> _allEvents = [];
  List<EventDetail> _pronites = [];
  List<EventDetail> _proshows = [];
  List<EventDetail> _creatorsCamp = [];
  List<EventDetail> _nesslist = [];
  List<EventDetail> _neuvlist = [];
  List<VenueModel> _venues = [];
  bool _isLoading = true;

  List<EventDetail> get allEvents => _allEvents;
  List<EventDetail> get pronites => _pronites;
  List<EventDetail> get proshows => _proshows;
  List<EventDetail> get nesslist => _nesslist;
  List<EventDetail> get neuvlist => _neuvlist;
  List<EventDetail> get creatorsCamp => _creatorsCamp;

  List<VenueModel> get venues => _venues;
  bool get isLoading => _isLoading;

  Future<void> fetchEvents() async {
    _isLoading = true;
    notifyListeners();
    try {
      _allEvents = viewModelMain.allEvents;
      _pronites = _allEvents
          .where((event) => event.type.toLowerCase() == "pronites")
          .toList();
      _proshows = _allEvents
          .where((event) => event.type.toLowerCase() == "proshows")
          .toList();
      _creatorsCamp = _allEvents
          .where((event) => event.type.toLowerCase() == "creators' camp")
          .toList();
      _nesslist = _allEvents
          .where((event) => event.type.toLowerCase() == "ness")
          .toList();
      _neuvlist = _allEvents
          .where((event) => event.type.toLowerCase() == "neuv")
          .toList();
      _venues = viewModelMain.venuesList;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
