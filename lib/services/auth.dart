import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:school_app/services/firestore_database.dart';

class Auth extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signInWithEmailAndPassword(String email, String password) async {
    final AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return authResult.user.uid.toString();
  }

   Future<String> changePassword(String password) async{
    FirebaseUser user = await _firebaseAuth.currentUser();

    String res = await user.updatePassword(password).then((_){
      print("here");
      return null;
    }).catchError((error){
      print("error"+error.toString());
      return ("changePassword" + error.toString());
    });

    return res.toString();
  }

  //void setUserLocation() async{
  //  final String userId = await _firebaseAuth.currentUser().then((value) => value.uid);
  //  Position pos = await UserLocation().getLocation();
  //  GeoPoint geoPoint = GeoPoint(pos.latitude,pos.longitude);
  //  print(geoPoint);
  //  await DatabaseService(userId: userId).setUserData({"current_position":geoPoint});
  //}

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

  void overwriteValues(Map<String, dynamic> mapValues) async {
    String userId = await _firebaseAuth.currentUser().then((value) => value.uid);
    print("overwriteValues with" + mapValues.toString());
    await DatabaseService(userId: userId).setUserData(mapValues);
  }

  void updateValues(Map<String, dynamic> mapValues) async {
    String userId = await _firebaseAuth.currentUser().then((value) => value.uid);
    print("updateUserData with" + mapValues.toString());
    await DatabaseService(userId: userId).updateUserData(mapValues);
  }
}