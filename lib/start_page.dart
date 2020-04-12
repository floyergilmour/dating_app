import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_app/User/user.dart';
import 'package:school_app/User/user_2.dart';
import 'package:school_app/components/bottomNavigationBarProvider.dart';
import 'package:school_app/components/mainAppBar.dart';
import 'package:school_app/components/hamburgerMenu.dart';
import 'package:school_app/pages/profile.dart';
import 'package:provider/provider.dart';
import 'package:school_app/pages/loginScreen.dart';
import 'package:flutter/foundation.dart';

import 'User/auth.dart';

class StartPage extends StatelessWidget with ChangeNotifier{
  //StartPage({Key key, this.user}) : super(key: key);
  //final FirebaseUser user;

  var currentTab = [
    Scaffold(
      body: Center(child: Text("Curriculum",style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900),)),
    ),
    Scaffold(body: Center(child: Text("Schedule",style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900),)),),
    Scaffold(body: Center(child: Text("Message",style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900),)),),
    Profile(),
    Scaffold(body: Center(child: Text("Logut",style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900),)),),
  ];

  @override
  Widget build(BuildContext context) {
    final NavbarProvider = Provider.of<BottomNavigationBarProvider>(context, listen: true);
    UserState2 _userState = Provider.of<UserState2>(context, listen: true);
    final _auth = Provider.of<Auth>(context);

    return Scaffold(
      body: currentTab[NavbarProvider.currentIndex],
      //drawer: hamburgerMenu(),
      //appBar: MainAppBar(
      //    appBarTitle: "Welcome Donny"+'${NavbarProvider.currentIndex.toString()}',
      //    appBarHeight: height,
      //    imageUrl:
      //        "/Users/donnyh/code/school_app/assets/images/mockProfileImage.jpeg"),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: NavbarProvider.currentIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text("Curriculum"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text("Schedule"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text("Messages"),
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

          if(index == 4){
            _auth.signOut();
            _userState.setStatus = UserStatus2.UnAuthenticated;
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
