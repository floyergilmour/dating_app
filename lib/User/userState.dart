import 'package:flutter/foundation.dart';

enum UserStatus2 { Uninitialized, Authenticated, UnAuthenticated }

class UserState2 with ChangeNotifier {
  UserStatus2 _status = UserStatus2.UnAuthenticated;

  UserStatus2 get status => _status;
  set setStatus(UserStatus2 s) {
    _status = s;
    notifyListeners();
  }

}