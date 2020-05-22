import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_app/User/userState.dart';
import 'package:school_app/services/location_service.dart';
import 'package:school_app/user/userLocation.dart';
import 'package:school_app/user/userSignUpLoginData.dart';
import 'package:school_app/pages/loginSignupPages/loginScreen.dart';
import 'package:provider/provider.dart';
import 'package:school_app/pages/splash.dart';
import 'package:school_app/pages/startPage.dart';
import 'package:school_app/components/bottomNavigationBarProvider.dart';
import 'package:school_app/services/auth.dart';
import 'package:school_app/components/formState.dart';
import 'package:school_app/services/formKey.dart';
import 'User/user.dart';
import 'package:school_app/themeColor/themeColor.dart';
import 'dart:async';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(SchoolApp());
}

class SchoolApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demop',
        theme: ThemeData(primarySwatch: MaterialColor(0xFFFA8080, color)),
        home: MultiProvider(
          providers: [
            StreamProvider<UserLocation>.value(
              value: LocationService().locationStream,
            ),
            ChangeNotifierProvider(
                create: (_) => BottomNavigationBarProvider()),
            ChangeNotifierProvider(create: (_) => Auth()),
            ChangeNotifierProvider(create: (_) => UserState()),
            ChangeNotifierProvider(create: (_) => User()),
            ChangeNotifierProvider(create: (_) => FormStatus()),
            ChangeNotifierProvider(create: (_) => FormKey()),
            ChangeNotifierProvider(create: (_) => UserSignUpLoginData()),
          ],
          child: HomePage(),
        ));
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    UserState _userState = Provider.of<UserState>(context);
    Auth _auth = Provider.of<Auth>(context);
    final streamLocation = Provider.of<UserLocation>(context, listen: true);
    User _user = Provider.of<User>(context);
    //
    //Map<String, dynamic> maps = {
    //  "current_location":
    //      GeoPoint(streamLocation.longitude, streamLocation.latitude)
    //};
    //Timer.periodic(Duration(seconds: 3), (Timer t) => _auth.updateValues(maps));
    //_user.setUserLocation(streamLocation);
    //_user.setUserLocation = streamLocation;
    switch (_userState.status) {
      case UserStatus.Uninitialized:
        print("main.dart: Splash(): Switch case Uninitialized");
        return Splash();
      case UserStatus.UnAuthenticated:
        print("main.dart: LoginScreen(): Switch case Authenticating or Unauthenticated");
        return LoginScreen();
      case UserStatus.Authenticated:
        print("main.dart: StartPage(): Authenticated");
        return StartPage();
    }
  }
}
