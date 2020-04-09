import 'package:flutter/material.dart';

class Profile extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          //SliverPersistentHeader(

          //  pinned: false,
          //  floating: true,
          //)
        ],
      ),
    );
  }
}
