import 'package:flutter/material.dart';
import 'package:school_app/mainAppBar/mainAppBar.dart';

class NavToNewPageBottomNav extends StatefulWidget {
  @override
  NavToNewPageBottomNavState createState() {
    return new NavToNewPageBottomNavState();
  }

}

class NavToNewPageBottomNavState extends State<NavToNewPageBottomNav> {
  String text = 'Home';
  int _selectedCountryIndex = 0;

  _onTap(int index) {
    setState(() {
      _selectedCountryIndex = index;
    });

    return new NewPage();
  }

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
      currentIndex: _selectedCountryIndex,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          title: Text("Curriculum"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          title: Text("Schedule"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          title: Text("Messages"),
        ),
      ],
      onTap: _onTap,
    );
  }
}

class NewPage extends StatelessWidget {
  var height = AppBar().preferredSize.height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
          appBarTitle: "Welcome Donny" ,
          appBarHeight: height,
          imageUrl:
          "/Users/donnyh/code/school_app/assets/images/mockProfileImage.jpeg"),
      body: Center(
          child: Text("New Page",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold))),
    );
  }
}