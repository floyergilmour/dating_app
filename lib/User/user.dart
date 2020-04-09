import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*
enum UserStatus{
  loggedIn,
  loggedOut,

}

class UserState with ChangeNotifier{
  UserStatus userStatus = UserStatus.loggedOut;
  Future<String> email;
  Future<String> password;

  UserState({
    Key key,
    this.email,
    this.password,
  });

  void setLoggedIn() {
  userStatus = UserStatus.loggedIn;
  notifyListeners();
  }

  void setLoggedOut() {
    userStatus = UserStatus.loggedOut;
    notifyListeners();
  }

}
 */

enum UserStatus { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserState with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  UserStatus _status = UserStatus.Uninitialized;

  UserState({Key key}) ;

  UserState.instance() : _auth = FirebaseAuth.instance {
    print("In the UserState.instance()");
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  UserStatus get status => _status;
  FirebaseUser get user => _user;

  Future<bool> signIn(String email, String password) async {
    try {
      _status = UserStatus.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _status = UserStatus.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = UserStatus.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future instantiate() async {

    _status = UserStatus.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    print("get rich or die tryin'");
    print("Firebase user = "+ firebaseUser.email.toString());
    if (firebaseUser == null) {
      print("UnAuthenticated here");
      _status = UserStatus.Unauthenticated;
    } else {
      print("Authenticated here");
      _user = firebaseUser;
      _status = UserStatus.Authenticated;
    }
    notifyListeners();
  }
}