import 'package:flutter/material.dart';

class DiscoveryState with ChangeNotifier {
  int _currentIndex = 0;

  void changeCurrentIndex(index) {
    _currentIndex = index;
    notifyListeners();
  }

  int get currentIndex => _currentIndex;
}