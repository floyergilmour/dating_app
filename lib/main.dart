import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_app/User/user.dart';
import 'package:school_app/User/user_2.dart';
import 'package:school_app/pages/loginScreen.dart';
import 'package:provider/provider.dart';
import 'package:school_app/pages/splash.dart';
import 'package:school_app/start_page.dart';
import 'package:school_app/components/bottomNavigationBarProvider.dart';
import 'package:school_app/User/auth.dart';

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
              ChangeNotifierProvider(create: (_) => UserState()),
              ChangeNotifierProvider(create: (_) => Auth()),
              ChangeNotifierProvider(create: (_) => UserState2()),
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
    UserState2 user = Provider.of<UserState2>(context);

    switch (user.status) {
    case UserStatus2.Uninitialized:
      print("main.dart: Splash(): Switch case Uninitialized");
      return Splash();
    case UserStatus2.UnAuthenticated:
      //case UserStatus.Authenticating:
      print("main.dart: LoginScreen(): Switch case Authenticating or Unauthenticated");
      return LoginScreen();
    case UserStatus2.Authenticated:
      print("main.dart: StartPage(): Authenticated");
      return StartPage();
    }
  }
}

