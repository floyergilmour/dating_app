import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_app/User/user.dart';
import 'package:school_app/pages/loginScreen.dart';
import 'package:provider/provider.dart';
import 'package:school_app/pages/splash.dart';
import 'package:school_app/start_page.dart';
import 'package:school_app/components/bottomNavigationBarProvider.dart';

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
        home: HomePage(),

    );
  }
}

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //UserState userState = Provider.of<UserState>(context, listen: true);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavigationBarProvider()),
        ChangeNotifierProvider(create: (_) => UserState.instance()),
      ],
      child: Consumer(
        builder: (context, UserState user, _) {
          print("Entering switch case ");
          switch (user.status) {
            case UserStatus.Uninitialized:
              print("Switch case Uninitialized");
              return Splash();
            case UserStatus.Unauthenticated:
            case UserStatus.Authenticating:
              return LoginScreen();
            case UserStatus.Authenticated:
              print("Switch case Authenticated");
              return StartPage(user: user.user);
          }
        },
      ),
    );
  }
}
