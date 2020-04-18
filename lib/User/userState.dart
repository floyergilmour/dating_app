import 'package:flutter/foundation.dart';

enum UserStatus { Uninitialized, Authenticated, UnAuthenticated }

class UserState with ChangeNotifier {
  UserStatus _status = UserStatus.Uninitialized;

  UserStatus get status => _status;

  set setStatus(UserStatus s) {
    if(s == UserStatus.UnAuthenticated){
    }
    _status = s;
    notifyListeners();
  }
}