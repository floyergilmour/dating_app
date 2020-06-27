import 'package:flutter/material.dart';
import 'package:school_app/components/profileBox.dart';
import 'package:school_app/main.dart';
import 'package:school_app/pages/loginSignupPages/loginScreen.dart';
import 'package:school_app/pages/profile.dart';
import 'package:school_app/pages/settings/setting.dart';
import 'package:school_app/pages/supliers/VenuePage.dart';

  class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    WidgetBuilder builder;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => Setting());
      case '/profile':
        return MaterialPageRoute(builder: (_) => Profile());
      //case '/venue':
      //  if (args is List<String>) {
      //    return MaterialPageRoute(
      //      builder: (_) => VenuePage(
      //        data: args,
      //      ),
      //    );
      //  }
      //  return _errorRoute();

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('This page does not exist or something went wrong'),
        ),
      );
    });
  }
}
