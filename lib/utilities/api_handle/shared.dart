import 'package:flutter/material.dart';

class SharedDataService with ChangeNotifier {
  String _selectedPlaceName = '';
  double _selectedPlaceLat = 0.0;
  double _selectedPlaceLng = 0.0;

  String get selectedPlaceName => _selectedPlaceName;
  double get selectedPlaceLat => _selectedPlaceLat;
  double get selectedPlaceLng => _selectedPlaceLng;

  void updateSelectedPlace(String placeName, double lat, double lng) {
    _selectedPlaceName = placeName;
    _selectedPlaceLat = lat;
    _selectedPlaceLng = lng;
    notifyListeners(); // Notify listeners of changes
  }
}
