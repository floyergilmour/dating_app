import 'package:flutter/material.dart';
import 'package:school_app/User/userState.dart';
import 'package:school_app/pages/loginScreen.dart';
import 'package:provider/provider.dart';
import 'package:school_app/pages/splash.dart';
import 'package:school_app/pages/start_page.dart';
import 'package:school_app/components/bottomNavigationBarProvider.dart';
import 'package:school_app/User/auth.dart';
import 'package:school_app/components/formState.dart';
import 'User/user.dart';
import 'package:school_app/themeColor/themeColor.dart';

void main() {
  runApp(SchoolApp());
}

class SchoolApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
          title: 'Flutter Demop',
          theme: ThemeData(primarySwatch: MaterialColor(0xFFFA8080, color)),
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => BottomNavigationBarProvider()),
              ChangeNotifierProvider(create: (_) => Auth()),
              ChangeNotifierProvider(create: (_) => UserState()),
              ChangeNotifierProvider(create: (_) => User()),
              ChangeNotifierProvider(create: (_) => FormStatus()),
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
