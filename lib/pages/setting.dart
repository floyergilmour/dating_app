import 'package:flutter/material.dart';
import 'package:school_app/User/userState.dart';
import 'package:provider/provider.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserState user = Provider.of<UserState>(context, listen: true);
    return Scaffold(
      body: Center(
          child: Container(
            alignment: Alignment.center,
            height: 300,
            width: 300,
            child: Text(
              "Settings",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            color: Colors.cyan,
          )),
    );
  }
}