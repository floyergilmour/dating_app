import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:school_app/User/user.dart';
import 'package:school_app/User/user_2.dart';
/*
abstract class BaseAuth extends ChangeNotifier{
  build(BuildContext context) {
    UserState2 userState = Provider.of<UserState2>(context, listen: true);
  }
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
}


 */
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