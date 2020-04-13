import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Auth extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signInWithEmailAndPassword(String email, String password) async {
    final AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    notifyListeners();
    return authResult.user.uid.toString();
  }


  Future<String> createUserWithEmailAndPassword(String email, String password) async {
    final AuthResult authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
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
}