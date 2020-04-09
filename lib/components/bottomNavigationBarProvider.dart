import 'package:flutter/material.dart';
import 'package:school_app/pages/loginScreen.dart';
import 'package:school_app/components/mainAppBar.dart';
import 'package:school_app/pages/profile.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 0;

  get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
