import 'package:flutter/material.dart';

class HamburgerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Spacer(flex: 1,),
          Expanded(
              flex: 2,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("/Users/donnyh/code/school_app/assets/images/hvitfeldtska.png"),
                            fit: BoxFit.scaleDown
                        )
                    ),
                  )
              )
          ),
          Expanded(
            flex: 3,
            child: ListView(children: <Widget>[
              ListTile(
                title: Text("Profile"),
                leading: Icon(Icons.person),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text("Venues"),
                leading: Icon(Icons.store),
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
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text("Logout"),
                leading: Icon(Icons.exit_to_app),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],),
          )
        ],
      )
    );
  }
}
