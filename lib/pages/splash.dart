import 'package:flutter/material.dart';
import 'package:school_app/User/user.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context, listen: true);
    sleep(const Duration(seconds: 3));
    print("Changing state in splash from state="+'${user.status}');
    user.instantiate();
    print("To state="+'${user.status}');
    return Material(
      child: Center(
        child: Text("Splash Screen"),
      ),
    );
  }
}