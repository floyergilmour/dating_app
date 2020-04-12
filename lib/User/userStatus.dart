import 'package:flutter/material.dart';

enum Gender {
  male,
  female,
  unknown,
  missing
}
 
enum UserType {
  admin,
  teacher,
  student,
  parent
}


class User {
  String userId;
  String firstName;
  String lastName;
  String middleName;
  UserType userType;
  //String classBelonging;
  String school;
  DateTime dateOfBirth;
  Gender gender;

  User({
  @required String firstName,
  @required String lastName,
  String middleName,
  @required UserType userType,
  //String classBelonging,
  @required String school,
  @required DateTime dateOfBirth,
  String gender}
    ) {
    this.userId = userId;
    this.firstName = firstName;
    this.lastName = lastName;
    [this.middleName = null];
    this.userType = userType;
    //this.classBelonging = classBelonging;
    this.school = school;
    this.dateOfBirth = dateOfBirth;
    [this.gender = toGender(gender)];
  }

  String getFullName() {
    return this.firstName + " " +this.lastName;
  }

  Gender toGender([String genderInput]){
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

  int getAge() {
    var parsedDate = this.dateOfBirth;
    var secondsDiff = DateTime.now().difference(parsedDate);
    //var age = secondsDiff
    var years = (secondsDiff.inDays/365).floor();
    return years;
  }

}
