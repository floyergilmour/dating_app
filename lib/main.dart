import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_app/User/user_state.dart';
import 'package:school_app/services/location_service.dart';
import 'package:school_app/themeColor/theme_color.dart';
import 'package:school_app/user/location.dart';
import 'package:school_app/user/user_sign_up_login_data.dart';
import 'package:school_app/pages/loginSignupPages/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:school_app/pages/splash.dart';
import 'package:school_app/pages/startPage.dart';
import 'package:school_app/components/bottom_navigation_bar_provider.dart';
import 'package:school_app/services/auth.dart';
import 'package:school_app/components/form_state.dart';
import 'package:school_app/services/form_key.dart';
import 'User/user.dart';
import 'components/route_generator.dart';

void main() {
  runApp(
    SchoolApp(),
  );
}

class SchoolApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<UserLocation>.value(
          value: LocationService().locationStream,
        ),
        ChangeNotifierProvider(create: (_) => BottomNavigationBarProvider()),
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => UserState()),
        ChangeNotifierProvider(create: (_) => User()),
        ChangeNotifierProvider(create: (_) => FormStatus()),
        ChangeNotifierProvider(create: (_) => FormKey()),
        ChangeNotifierProvider(create: (_) => UserSignUpLoginData()),
      ],
      child: MaterialApp(
        initialRoute: "/",
        onGenerateRoute: RouteGenerator.generateRoute,
        theme: ThemeData(primarySwatch: MaterialColor(0xFFFA8080, color)),
        title: 'School App',
        home: HomePage(),
      ),
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
    UserState _userState = Provider.of<UserState>(context);
    switch (_userState.status) {
      case UserStatus.Uninitialized:
        print("main.dart: Splash(): Switch case Uninitialized");
        return Splash();
      case UserStatus.UnAuthenticated:
        print(
            "main.dart: LoginScreen(): Switch case Authenticating or Unauthenticated");
        return LoginScreen();
      case UserStatus.Authenticated:
        print("main.dart: StartPage(): Authenticated");
        return StartPage();
    }
  }
}
