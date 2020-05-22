import 'dart:async';

import 'package:location/location.dart';
import 'package:school_app/user/userLocation.dart';

/*
* From this website: https://www.filledstacks.com/snippet/build-a-flutter-location-service/
* */
class LocationService {

  @override
  void initState() {
    Timer.periodic(Duration(minutes: 1), (Timer t) => LocationService());
  }


  UserLocation _currentLocation;

  Location location = new Location();

  StreamController<UserLocation> _locationController =
  StreamController<UserLocation>.broadcast();

  Stream<UserLocation> get locationStream => _locationController.stream;

  LocationService() {
    // Request permission to use location
    location.requestPermission().then((PermissionStatus granted) {
      print("granted: $granted");
      if (granted == PermissionStatus.GRANTED) {
        // If granted listen to the onLocationChanged stream and emit over our controller
        print("location: $location");
        location.getLocation().then((locationData) =>
        {
        _locationController.add(UserLocation(
        latitude: locationData.latitude,
        longitude: locationData.longitude,
        ))
      }
      );
      //location.onLocationChanged().listen((locationData) {
      //  print("locationData: $locationData");
      //  if (locationData != null) {
      //    _locationController.add(UserLocation(
      //      latitude: locationData.latitude,
      //      longitude: locationData.longitude,
      //    ));
      //  }
      //});
    }
    });
  }

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } catch (error) {
      print("Could not get the location: $error");
    }
    return _currentLocation;
  }
}
