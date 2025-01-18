import 'package:alcheringa/Common/globals.dart';
import 'package:flutter/material.dart';

import '../Model/stall_model.dart';
import '../Model/view_model_main.dart';

class StallProvider with ChangeNotifier {
  List<StallModel> _stalls = [];

  List<StallModel> _filteredStalls = [];
  bool _isLoading = false;

  List<StallModel> get stalls => _stalls;
  bool get isLoading => _isLoading;

  Future<void> fetchStalls() async {
    _isLoading = true;
    notifyListeners();

    try {
      final fetchedStalls = viewModelMain.stallList;
      _stalls = fetchedStalls;
      _filteredStalls = List.from(_stalls);
    } catch (e) {
      print('Error fetching stalls: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
