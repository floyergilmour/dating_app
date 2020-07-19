import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/services/auth.dart';
import 'package:school_app/User/user_state.dart';
import 'package:school_app/User/user.dart';

class HamburgerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserState _userState = Provider.of<UserState>(context, listen: true);
    final Auth _auth = Provider.of<Auth>(context);
    User _user = Provider.of<User>(context, listen: true);
    return Drawer(
        child: Column(
      children: <Widget>[
        Expanded(
            flex: 0,
            child: Container(

                //height: MediaQuery.of(context).size.width,
                child: DrawerHeader(

              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: _user.profilePictureNetwork,
                      fit: BoxFit.fitHeight
                  )
              ),
            ))),
        Expanded(
          flex: 1,
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text("Profile"),
                leading: Icon(Icons.store),
                onTap: () => Navigator.of(context).pushNamed(
                  '/profile',
                ),
              ),
              ListTile(
                title: Text("Schedule"),
                leading: Icon(Icons.calendar_today),
              ),
              ListTile(
                title: Text("Messages"),
                leading: Icon(Icons.message),
              ),
              ListTile(
                title: Text("Groups"),
                leading: Icon(Icons.group),
              ),
              ListTile(
                title: Text("Settings"),
                leading: Icon(Icons.settings),
                onTap: () => Navigator.of(context).pushNamed(
                  '/settings',
                ),
              ),
              ListTile(
                title: Text("Logout"),
                leading: Icon(Icons.exit_to_app),
                onTap: () {
                  _auth.signOut();
                  _userState.setStatus = UserStatus.UnAuthenticated;
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        )
      ],
    ));
  }
}
