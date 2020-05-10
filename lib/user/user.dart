import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:school_app/extensions/extensions.dart';

enum Gender { male, female, unknown, missing }

enum UserType { admin, teacher, student, parent, missing }

enum Product { premium, free }

class User extends ChangeNotifier{
  Firestore db = Firestore.instance;

  String _userId, _firstName, _lastName, _school, _email, _description, _employer, _title, _name;
  List<String> _ideologies, _interests, _religions;
  UserType _userType;
  Product _product;
  int _age;
  Gender _gender;

  String get userId => _userId;
  String get firstName => _firstName;
  String get name => _name;
  String get lastName => _lastName;
  String get school => _school;
  String get email => _email;
  String get description => _description;
  String get employer => _employer;
  String get title => _title;
  List<dynamic> get ideologies => _ideologies;
  List<String> get interests => _interests;
  List<String> get religions => _religions;
  UserType get userType => _userType;
  Product get product => _product;
  int get age => _age;
  Gender get gender => _gender;

  set setFirstName(String value) {
    _firstName = value;
    notifyListeners();
  }
  set setLastName(String value) {
    _lastName = value;
    notifyListeners();
  }

  set setName(String value) {
    _name = value;
    notifyListeners();
  }

  set setSchool(String value) {
    _school = value;
    notifyListeners();
  }
  set setEmail(String value) {
    _email = value;
    notifyListeners();
  }
  set setDescription(String value) {
    _description = value;
    notifyListeners();
  }
  set setEmployer(String value) {
    _employer = value;
    notifyListeners();
  }
  set setTitle(String value) {
    _title = value;
    notifyListeners();
  }

  set setAge(int value) {
    _age = value;
    notifyListeners();
  }

  set setProduct(Product value) {
    _product = value;
    notifyListeners();
  }

  set setIdeologies(List<String> value) {
    _ideologies = value;
    notifyListeners();
  }

  set setReligions(List<String> value) {
    _religions = value;
    notifyListeners();
  }

  set setInterests(List<String> value) {
    _interests = value;
    notifyListeners();
  }

  String getFullName() {
    var fName = firstName == null ? '' : this.firstName+" ";
    var lName = lastName == null ? '' : this.lastName;
    return fName.capitalize() + lName.capitalize();
  }

  String getInitials() {
    var fName = firstName == null ? '' : this.firstName[0].toUpperCase();
    var lName = lastName == null ? '' : this.lastName[0].toUpperCase();
    return fName + lName;
  }
  Gender stringToGender([String genderInput]){
    if(genderInput == null){
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
    if(userTypeInput == null){
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

  Product stringToProduct([String productInput]){
    if(productInput == null){
      return Product.free;
    }
    else{
      switch(productInput){
        case "premium": return Product.premium;
        case "free": return Product.free;
      }
    }
  }

  Future<bool> setUserSuccessful(String userId) async {
    print(userId);
    try{
      DocumentSnapshot userResult = (await db
          .collection('user')
          .document(userId)
          .get());
      print(userResult.data);

      Iterable ideologiesRaw = userResult.data["ideologies"] == null ? [] : userResult.data["ideologies"];
      Iterable interestsRaw = userResult.data["interests"] == null ? [] : userResult.data["interests"];
      Iterable religionsRaw = userResult.data["religions"] == null ? [] : userResult.data["religions"];


      _userId = userId;
      print("_userId");
      _firstName = userResult.data["first_name"];
      print("_first_name");
      _lastName = userResult.data["last_name"];
      print("_last_name");
      _name = userResult.data["name"];
      print("_name");
      _school = userResult.data["school"];
      print("_school");
      _email = userResult.data["email"];
      print("_email");
      _userType = stringToUserType(userResult.data["user_type"]);
      print("_userType");
      _product = stringToProduct(userResult.data["product"]);
      print("_product");
      //_dateOfBirth = DateTime(dob.year, dob.month, dob.day);
      print("//");
      _age = userResult.data["age"];
      print("_age");
      _gender = stringToGender(userResult.data["gender"]);
      print("_gender");
      _description = userResult.data["description"];
      print("_description");
      _ideologies = List.from(ideologiesRaw);
      print("_ideologies");
      _interests = List.from(interestsRaw);
      print("_interests");
      _religions = List.from(religionsRaw);
      print("_religions");
      _title = userResult.data["title"];
      print("_title");
      _employer = userResult.data["employer"];
print("_employer");
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
      _name = null;
      _school = null;
      _email =null;
      _userType =UserType.admin;
      _gender =Gender.missing;
      _description ='';
      _ideologies =[];
      _interests =[];
      _religions =[];
      _title = null;
      _employer = null;
      notifyListeners();
      return false;
    }

  }

}
