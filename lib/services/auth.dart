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

  void _changePassword(String password) async{
    FirebaseUser user = await _firebaseAuth.currentUser();

    user.updatePassword(password).then((_){
      print("Succesfull changed password");
    }).catchError((error){
      print("Password can't be changed" + error.toString());
    });
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

  void overwriteValues(String userId, Map<String, dynamic> mapValues) async {
    print("overwriteValues with" + mapValues.toString());
    await DatabaseService(userId: userId).setUserData(mapValues);
  }

  void updateValues(String userId, Map<String, dynamic> mapValues) async {
    print("updateUserData with" + mapValues.toString());
    await DatabaseService(userId: userId).updateUserData(mapValues);
  }
}