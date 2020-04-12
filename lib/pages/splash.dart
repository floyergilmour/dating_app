import 'package:flutter/material.dart';
import 'package:school_app/User/user.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class Splash extends StatelessWidget with ChangeNotifier {
  Splash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserState user = Provider.of<UserState>(context, listen: true);
    sleep(const Duration(seconds: 5));
    print("Changing state in splash from state=" + '${user.status}');
    user.instantiate();
    print("To state=" + '${user.status}');
    return Material(
      child: Row(
        children: <Widget>[
          Text(
            "Loading", style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900),
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
