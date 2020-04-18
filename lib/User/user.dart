import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:school_app/extensions/extensions.dart';

enum Gender { male, female, unknown, missing }

enum UserType { admin, teacher, student, parent, missing }

class User extends ChangeNotifier{
  Firestore db = Firestore.instance;

  String _userId, _firstName, _lastName, _middleName, _school, _email, _description;
  List<String> _ideologies, _interests, _religions;
  UserType _userType;
  DateTime _dateOfBirth;
  Gender _gender;

  String get userId => _userId;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get middleName => _middleName;
  String get school => _school;
  String get email => _email;
  String get description => _description;
  List<String> get ideologies => _ideologies;
  List<String> get interests => _interests;
  List<String> get religions => _religions;
  UserType get userType => _userType;
  DateTime get dateOfBirth => _dateOfBirth;
  Gender get gender => _gender;
  int get age {

    if (_dateOfBirth == null) {
      return null;
    }
    var secondsDiff = DateTime.now().difference(_dateOfBirth.toLocal());
    var years = (secondsDiff.inDays/365).floor();
    return years;
  }

  String getFullName() {
    var fName = firstName.isEmpty ? '' : this.firstName+" ";
    var mName = middleName.isEmpty ? '' : this.middleName+" ";
    var lName = lastName.isEmpty ? '' : this.lastName;
    return fName.capitalize() + mName.capitalize() + lName.capitalize();
  }

  String getInitials() {
    var fName = firstName.isEmpty ? '' : this.firstName[0].toUpperCase();
    var lName = lastName.isEmpty ? '' : this.lastName[0].toUpperCase();
    return fName + lName;
  }
  Gender stringToGender([String genderInput]){
    if(genderInput.isEmpty){
      return Gender.missing;
    }
    else{
      switch(genderInput){
        case "male": return Gender.male;
        case "female": return Gender.female;
        case "unknown": return Gender.unknown;
      }
    }
  }

  UserType stringToUserType([String userTypeInput]){
    if(userTypeInput.isEmpty){
      return UserType.missing;
    }
    else{
      switch(userTypeInput){
        case "admin": return UserType.admin;
        case "teacher": return UserType.teacher;
        case "student": return UserType.student;
        case "parent": return UserType.parent;
      }
    }
  }

  Future<bool> setUserSuccessful(String userId) async {
    try{
      DocumentSnapshot userResult = (await db
          .collection('user')
          .document(userId)
          .get());
      print(userResult.data);
      DateTime dob = userResult.data["dateOfBirth"].toDate();

      _userId = userId;
      _firstName = userResult.data["firstName"];
      _lastName = userResult.data["lastName"];
      _middleName = userResult.data["middleName"];
      _school = userResult.data["school"];
      _email = userResult.data["email"];
      _userType = stringToUserType(userResult.data["userType"]);
      _dateOfBirth = DateTime(dob.year, dob.month, dob.day);
      _gender = stringToGender(userResult.data["gender"]);
      _description = userResult.data["description"];
      _ideologies = List.from(userResult.data["ideologies"]);
      _interests = List.from(userResult.data["interests"]);
      _religions = List.from(userResult.data["religions"]);

      notifyListeners();
      return true;
    }
    catch(error){
      print('========= Error in getting data =========');
      print(error);
      print("Setting default values");

      _userId = userId;
      _firstName = null;
      _lastName = null;
      _middleName = null;
      _school = null;
      _email =null;
      _userType =UserType.admin;
      _dateOfBirth =null;
      _gender =Gender.missing;
      _description ='';
      _ideologies =[];
      _interests =[];
      _religions =[];
      notifyListeners();
      return false;
    }

  }

}
