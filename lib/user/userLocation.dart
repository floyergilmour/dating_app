import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserLocation extends ChangeNotifier{
  double longitude = 1.1;
  double latitude = 1.1;

  UserLocation({this.latitude, this.longitude});

  @override
  String toString(){
    return "(Longitude: ${longitude.toString()}, Latitude: ${latitude.toString()} )";
  }

  set setLongitude(num lat) {
    longitude = lat;
    notifyListeners();
  }

  set setLatitude(num long) {
    longitude = long;
    notifyListeners();
  }

}

