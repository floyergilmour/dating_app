import 'package:flutter/material.dart';
import 'package:school_app/components/profile_box.dart';
import 'package:school_app/components/supliers/venue_page.dart';
import 'package:school_app/main.dart';
import 'package:school_app/pages/loginSignupPages/login_screen.dart';
import 'package:school_app/pages/profile.dart';
import 'package:school_app/pages/settings/setting.dart';
import 'package:school_app/pages/supliers/VenuePage.dart';

  class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed

    WidgetBuilder builder;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => Setting());
      case '/profile':
        return MaterialPageRoute(builder: (_) => Profile());
      case '/venue':
        final VenuePage args = settings.arguments;
        if (args is VenuePage) {
          return MaterialPageRoute(
            builder: (_) => VenuePage(
            args.title,
              args.description,
            ),
          );
        }
        return _errorRoute();

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
