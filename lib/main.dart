import 'package:flutter/material.dart';
import 'package:school_app/User/User.dart';
import 'sideDrawer/sideDrawer.dart';
import 'mainAppBar/mainAppBar.dart';
import 'package:school_app/NavToNewPageBottomNav/NavToNewPageBottomNav.dart';
import 'package:school_app/loginScreen/loginScreen.dart';

void main() {
  runApp(SchoolApp());
}

final String HomePageTitle = "Hvitfedltska Gymnasiet";

class SchoolApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demop',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: loginScreen(),
    );
  }
}

class StartPage extends StatefulWidget {
  StartPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int  selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    var height = AppBar().preferredSize.height;
    var person1 = User(
        firstName: "Donny",
        lastName: "Ho",
        userType: UserType.student,
        classBelonging: "3c",
        school: "Hvitfeldstka Gymnasiet",
        dateOfBirth: "1990-08-21",
        gender: Gender.male);

    final _pageOptions = [
      Text("Person", style: TextStyle(fontSize: 18.0),),
      Text("Home", style: TextStyle(fontSize: 18.0),),
      Text("Messages", style: TextStyle(fontSize: 18.0),),
    ];

    return Scaffold(
      drawer: sideDrawer(),
      appBar: MainAppBar(
          appBarTitle: "Welcome " + person1.getFullName(),
          appBarHeight: height,
          imageUrl:
              "/Users/donnyh/code/school_app/assets/images/mockProfileImage.jpeg"),
      body: Center(
        child: ListView(
          children: <Widget>[
            Center(child: Text(person1.getFullName(),style: TextStyle(fontSize: 18.0),)),
            Center(child: Text(person1.getAge().toString(),style: TextStyle(fontSize: 18.0),)),
            Center(child: _pageOptions[selectedPage]),
            ]
          ),
      )
        ,
      //Center(
      //child:
      //Column(
      //  mainAxisAlignment: MainAxisAlignment.center,
      //  children: <Widget>[
      //    Text(
      //      'You have pushed the button this many times:',
      //    ),
      //    Text(
      //      '$_counter',
      //      style: Theme.of(context).textTheme.headline4,
      //    ),
      //  ],
      //),
      //),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: NavToNewPageBottomNav(),
    );
  }
}
