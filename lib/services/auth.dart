import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:school_app/services/firestore_database.dart';

class Auth extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final List<String> USER_FIELDS = ['userId', 'firstName', 'lastName', 'middleName', 'school', 'email', 'userType', 'dateOfBirth', 'gender', 'description', 'ideologies', 'interests', 'religions', 'title', 'employer',];

  Future<String> signInWithEmailAndPassword(String email, String password) async {
    final AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    notifyListeners();
    return authResult.user.uid.toString();
  }


  Future<String> createUserWithEmailAndPassword(String email, String password) async {
    final AuthResult authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    Map<String, String> userEmail = {"email":authResult.user.email.toString()};
    await DatabaseService(userId: authResult.user.uid.toString()).setUserData(userEmail);
    notifyListeners();
    return authResult.user.uid.toString();
  }


  Future<String> currentUser() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    notifyListeners();
    return user?.uid.toString();
  }

  Future<void> signOut() async {
    _firebaseAuth.signOut();
    notifyListeners();
  }

  void _updateValue(String value, String field) async {
    String _userId = _firebaseAuth
        .currentUser()
        .then((value) => value.uid.toString())
        .catchError((e) => print(e))
        .toString();

    Firestore()
        .runTransaction(
          (Transaction transaction) {
            Firestore
                .instance
                .document(_userId)
                .updateData({field: value});
            },
    );
  }

}