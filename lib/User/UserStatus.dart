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
  String firstName;
  String lastName;
  String middleName;
  UserType userType;
  String classBelonging;
  String school;
  String dateOfBirth;
  Gender gender;

  User({
  @required String firstName,
  @required String lastName,
  String middleName,
  @required UserType userType,
  String classBelonging,
  @required String school,
  @required String dateOfBirth,
  Gender gender}
    ) {
  this.firstName = firstName;
  this.lastName = lastName;
  [this.middleName = null];
  this.userType = userType;
  this.classBelonging = classBelonging;
  this.school = school;
  this.dateOfBirth = dateOfBirth;
  [this.gender = Gender.missing];
  }

  String getFullName() {
    return this.firstName + " " +this.lastName;
  }

  int getAge() {
    var parsedDate = DateTime.parse(this.dateOfBirth);
    var secondsDiff = DateTime.now().difference(parsedDate);
    //var age = secondsDiff
    var years = (secondsDiff.inDays/365).floor();
    return years;
  }

}
