import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserLocation {
  double longitude;
  double latitude;

  UserLocation({this.latitude, this.longitude});

  @override
  String toString(){
    return "(Longitude: ${longitude.toString()}, Latitude: ${latitude.toString()} )";
  }

  set setLongitude(num lat) {
    longitude = lat;
    //notifyListeners();
  }

  set setLatitude(num long) {
    longitude = long;
  }

}

