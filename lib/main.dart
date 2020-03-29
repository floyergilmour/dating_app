import 'package:flutter/material.dart';
import 'package:school_app/User/User.dart';
import 'sideDrawer/sideDrawer.dart';
import 'mainAppBar/mainAppBar.dart';

void main() {
  runApp(MyApp());
}

final String HomePageTitle = "Hvitfedltska Gymnasiet";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demop',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: MyHomePage(title: HomePageTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int  selectedPage = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
      Text("Person",),
      Text("Home",),
      Text("Messages"),
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
            Text(person1.getFullName()),
            Text(person1.getAge().toString()),
            _pageOptions[selectedPage],
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
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedPage,
          onTap: (index) {
            setState(() {
              selectedPage = index;
            });
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
      ),
    );
  }
}
