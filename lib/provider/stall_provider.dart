import 'package:flutter/material.dart';

import '../Model/stall_model.dart';
import '../Model/view_model_main.dart';

class StallProvider with ChangeNotifier {
  List<StallModel> _stalls = [];
  bool _isLoading = false;

  List<StallModel> get stalls => _stalls;
  bool get isLoading => _isLoading;

  Future<void> fetchStalls() async {
    _isLoading = true;
    notifyListeners();

    try {
      final fetchedStalls = await ViewModelMain().getStalls();
      _stalls = fetchedStalls;
    } catch (e) {
      print('Error fetching stalls: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
