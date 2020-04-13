import 'package:flutter/material.dart';
import 'package:school_app/User/userState.dart';
import 'package:school_app/pages/loginScreen.dart';
import 'package:provider/provider.dart';
import 'package:school_app/pages/splash.dart';
import 'package:school_app/start_page.dart';
import 'package:school_app/components/bottomNavigationBarProvider.dart';
import 'package:school_app/User/auth.dart';

import 'User/user.dart';

void main() {
  runApp(SchoolApp());
}

class SchoolApp extends StatelessWidget {
  //final UserStatus userState = UserStatus.Unauthenticated;
  //FirebaseUser firebaseUser;

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
          title: 'Flutter Demop',
          theme: ThemeData(primarySwatch: Colors.amber),
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                  create: (_) => BottomNavigationBarProvider()),
              ChangeNotifierProvider(create: (_) => Auth()),
              ChangeNotifierProvider(create: (_) => UserState()),
              ChangeNotifierProvider(create: (_) => User()),
            ],
            child: HomePage(),
          )

      );
  }
}


class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    UserState user = Provider.of<UserState>(context);

    switch (user.status) {
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

