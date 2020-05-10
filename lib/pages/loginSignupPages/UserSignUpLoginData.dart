import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:school_app/user/user.dart';
import 'package:school_app/extensions/extensions.dart';

class UserSignUpLoginData extends ChangeNotifier{

  String _email;
  String _password;
  String _name;
  int _age;
  Gender _gender;
  Set<String> _genderPreferences;

  List<String> get getgenderPreferencesAsListOfStrings => genderPreferences.toList();

  set setName(String value) {
    _name = value;
    notifyListeners();
  }
  set setGender(Gender value) {
    _gender = value;
    notifyListeners();
  }

  String get email => _email;
  String get password => _password;
  String get name => _name;
  int get age => _age;
  Gender get gender => _gender;
  Set<String> get genderPreferences => _genderPreferences;

  setGenderPreferences(String gender, bool likes) {

    if(["Males","Females"].contains(gender)) {
      likes ? genderPreferences.add(gender) : genderPreferences.remove(gender);
      notifyListeners();
    }else{
      throw new Exception("Gender: $gender does not exist");
    }

  }
}
