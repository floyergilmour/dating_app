import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:school_app/components/types.dart';


class UserSignUpLoginData extends ChangeNotifier{

  String _email;
  String _password;
  String _name;
  int _age;
  Gender _gender = Gender.missing;
  Set<String> _genderPreferences = {};

  String get email => _email;
  String get password => _password;
  String get name => _name;
  int get age => _age;
  Gender get gender => _gender;
  Set<String> get genderPreferences => _genderPreferences;
  List<String> get getgenderPreferencesAsListOfStrings => genderPreferences.toList();

  set setName(String value) {
    _name = value;
    notifyListeners();
  }
  set setGender(Gender value) {
    _gender = value;

    notifyListeners();
    print(_gender);
  }
  set setAge(int value) {
    _age = value;
    notifyListeners();
  }
  set setEmail(String value) {
    _email = value;
    notifyListeners();
  }
  set setPassword(String value) {
    _password = value;
    notifyListeners();
  }
  set addGenderPreferences(String value) {
    _genderPreferences.add(value);
    notifyListeners();
  }
  set removeGenderPreferences(String value) {
    _genderPreferences.remove(value);
    notifyListeners();
  }

  setGenderPreferences(String gender, bool likes) {

    if(["Males","Females"].contains(gender)) {
      likes ? addGenderPreferences = gender : removeGenderPreferences = gender;
      notifyListeners();
    }else{
      throw new Exception("Gender: $gender does not exist");
    }
  }

  bool validSignupInfo(){
    assert(_email != null);
    assert(_password != null);
    assert(_name != null);
    assert(_age >= 18);
    assert(_gender != null);
    assert(_gender != Gender.missing);
    assert(_genderPreferences != null);
    assert(_genderPreferences.length > 0);
  }
}
