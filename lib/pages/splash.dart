import 'package:flutter/material.dart';
import 'package:school_app/User/userState.dart';
import 'package:provider/provider.dart';

class Splash extends StatelessWidget with ChangeNotifier {
  Splash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserState user = Provider.of<UserState>(context, listen: true);
    print("Changing state in splash from state=" + '${user.status}');
    user.setStatus = UserStatus.UnAuthenticated;
    print("To state=" + '${user.status}');
    return Material(
      color: Color.fromRGBO(250, 128, 128, 1),
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              "Loading",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Colors.white),
            ),
          ),
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
