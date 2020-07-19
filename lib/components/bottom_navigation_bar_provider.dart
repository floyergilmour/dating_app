import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 1;

  get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
