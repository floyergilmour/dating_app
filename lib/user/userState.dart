import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum UserStatus { Uninitialized, Authenticated, UnAuthenticated }

class UserState extends ChangeNotifier{

  UserStatus _status = UserStatus.UnAuthenticated;

  UserStatus get status => _status;

  set setStatus(UserStatus s) {
    _status = s;
    notifyListeners();
  }
}