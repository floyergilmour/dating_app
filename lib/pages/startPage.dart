import 'dart:async';

import 'package:flutter/material.dart';
import 'package:school_app/User/userState.dart';
import 'package:school_app/components/bottomNavigationBarProvider.dart';
import 'package:school_app/pages/profile.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:school_app/pages/settings/setting.dart';
import 'package:school_app/services/auth.dart';
import 'package:school_app/User/user.dart';

class StartPage extends StatelessWidget with ChangeNotifier {
  @override
  Widget build(BuildContext context) {
    final BottomNavigationBarProvider NavbarProvider =
        Provider.of<BottomNavigationBarProvider>(context, listen: true);
    final UserState _userState = Provider.of<UserState>(context, listen: true);
    final Auth _auth = Provider.of<Auth>(context);


    final currentTab = [
      Setting(),
      Profile(),
      //Consumer<User>(builder: (_, user, __) => Profile()),
    ];


    return Scaffold(
      body: currentTab[NavbarProvider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: NavbarProvider.currentIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("Settings"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            title: Text("Logout"),
          )
        ],
        onTap: (index) {
          //print("set location");
          //print(streamLocation);
          //_user.setUserLocation = streamLocation;
          if (index == 2) {
            _auth.signOut();
            _userState.setStatus = UserStatus.UnAuthenticated;
            NavbarProvider.currentIndex = 0;
          } else {
            NavbarProvider.currentIndex = index;
          }
          notifyListeners();
        },
      ),
    );
  }
}
