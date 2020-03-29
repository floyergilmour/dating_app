/*
import 'package:flutter/material.dart';

class bottomNavigationBar extends StatelessWidget {
  bottomNavigationBar({
    Key key,
    @required this.selectedPage,
  })
      :super(key: key);

  final int selectedPage; // default is 56.0

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: selectedPage,
        onTap: (int index) {
          setState(
                  () {
                selectedPage = index;
              }
          );
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Person")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.message),
              title: Text("Messages")
          ),
        ]
    );
  }

}
*/