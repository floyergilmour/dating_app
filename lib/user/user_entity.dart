import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:school_app/components/types.dart';
import 'package:school_app/user/location.dart';
import 'package:school_app/user/supplier.dart';
import 'package:school_app/user/user.dart';

enum Country { SE, DK, FI, NO, US, UK, FR, DE, ES, IT}

class UserEntity extends ChangeNotifier{

  String userEntityId;
  String email;
  String description;
  UserType type;
  DateTime createDate;
  UserLocation location;
  Image picture;
  NetworkImage pictureNetwork;
  String pictureUrl;
  UserEntity(
      this.userEntityId,
      this.email,
      this.type,
      this.createDate,
      this.location,
      this.picture,
      this.pictureNetwork,
      this.pictureUrl
      );
}

mixin ContactPerson{
  String firstName;
  String lastName;
  String position;
  String phoneNumber;
  Country country;
}