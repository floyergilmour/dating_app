import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_app/User/userStatus.dart';
import 'dart:io';

enum UserStatus { Uninitialized, Authenticated, Unauthenticated }

class UserState with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  UserStatus _status = UserStatus.Unauthenticated;
  Firestore db = Firestore.instance;
  String userId;
  User _loggedInUser;

  UserState({Key key}) ;

  //UserState.instance() : _auth = FirebaseAuth.instance {
  //  print("user.dart: UserState.instance()");
  //  sleep(const Duration(seconds: 10));
  //  _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  //}

  User get loggedInUser => _loggedInUser;
  UserStatus get status => _status;
  FirebaseUser get user => _user;
  String get firstName => _loggedInUser.firstName;

  Future<bool> signIn(String email, String password) async {
    try {
      print(DateTime.now().toString() + ": user.dart : signIn() : email="+email);
      print(DateTime.now().toString() + ": user.dart : signIn() : password="+password);
      print(DateTime.now().toString() + ": user.dart : signIn() : _auth="+_auth.toString());
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      //await setUserData();
      _status = UserStatus.Authenticated;
      print(DateTime.now().toString() + ": user.dart: signIn() SUCCESS: status: "+ _status.toString());
      setUserData();
      notifyListeners();
      return true;
    } catch (e) {
      _status = UserStatus.Unauthenticated;
      print(DateTime.now().toString() + ": user.dart: signIn() : FAIL: "+ _status.toString());
      print("======================= ERROR =======================");
      print(e);
      print("======================= ERROR =======================");
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = UserStatus.Unauthenticated;
    print(DateTime.now().toString() + ": user.dart: signOut(): status: "+ _status.toString());
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void instantiate() async {
    _status = UserStatus.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    print("======AUTO CHANGE======");
    if (firebaseUser == null) {
      print(DateTime.now().toString() + ": user.dart: _onAuthStateChanged: UnAuthenticated");
      _status = UserStatus.Unauthenticated;
    } else {
      print(DateTime.now().toString() + ": user.dart: firebaseUser: "+ firebaseUser.email.toString());
      print(DateTime.now().toString() + ": user.dart: _onAuthStateChanged: Authenticated");
      _user = firebaseUser;
      _status = UserStatus.Authenticated;
    }
    notifyListeners();
  }

  Future<bool> setUserData() async {
    DocumentSnapshot userResult = (await db
        .collection('user')
        .document('MQLe4apT41ZQXgwVBpgj8cg2LzI3')
        .get());
    print("user.dart: setUserData: userResult: " + userResult.data["gender"] + " " + userResult.data["email"]);
    final dob = userResult.data["dateOfBirth"].toDate();


    User userObject = User(
      firstName: userResult.data["firstName"],
      lastName: userResult.data["firstName"],
      userType: UserType.student,
      school: "Harvard",
      dateOfBirth: DateTime(dob.year ,dob.month,dob.day),
      gender: userResult.data["gender"]
    );

    _loggedInUser =  userObject;
    print("user.dart: setUserData: _loggedInUser: " + _loggedInUser.firstName.toString());
    notifyListeners();
    return true;
  }
}