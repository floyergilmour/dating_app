import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DatabaseService extends ChangeNotifier{
  final String userId;

  DatabaseService({this.userId});

  final CollectionReference userCollection =
      Firestore.instance.collection("user");

  Future setUserData(Map<String, dynamic> userDataMap) async {
    return await userCollection.document(userId).setData(userDataMap);
  }

  Future updateUserData(Map<String, dynamic> userDataMap) async {
    return await userCollection.document(userId).updateData(userDataMap);
  }
}
