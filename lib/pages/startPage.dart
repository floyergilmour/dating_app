import 'package:flutter/material.dart';
import 'package:school_app/User/userState.dart';
import 'package:school_app/components/bottomNavigationBarProvider.dart';
import 'package:school_app/pages/profile.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:school_app/pages/setting.dart';

import 'package:school_app/services/auth.dart';

class StartPage extends StatelessWidget with ChangeNotifier{

  var currentTab = [
    Setting(),
    Profile(),
    //ProfileSettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    final NavbarProvider = Provider.of<BottomNavigationBarProvider>(context, listen: true);
    UserState _userState = Provider.of<UserState>(context, listen: true);
    final _auth = Provider.of<Auth>(context);

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

          if(index == 2){
            _auth.signOut();
            _userState.setStatus = UserStatus.UnAuthenticated;
            NavbarProvider.currentIndex = 0;
            //userState.dispose();
          }
          else{
            NavbarProvider.currentIndex = index;
          }
          notifyListeners();
        },
      ),
    );
  }
}
