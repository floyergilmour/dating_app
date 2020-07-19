import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:school_app/components/types.dart';
import 'package:school_app/user/location.dart';
import 'package:school_app/user/user.dart';
import 'package:school_app/user/user_entity.dart';

class Supplier extends UserEntity with ContactPerson{

  String supplierName;
  ContactPerson contactPerson;

  Supplier(
  String userEntityId,
  String email,
  UserType type,
  DateTime createDate,
  UserLocation location,
  Image picture,
  NetworkImage pictureNetwork,
  String pictureUrl,
  ):super(
      userEntityId,
      email,
      type,
      createDate,
      location,
      picture,
      pictureNetwork,
      pictureUrl);
}