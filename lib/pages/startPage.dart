import 'package:flutter/material.dart';
import 'package:school_app/User/userState.dart';
import 'package:school_app/components/bottomNavigationBarProvider.dart';
import 'package:school_app/components/hamburgerMenu.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:school_app/components/supliers/find_suppliers.dart';
import 'package:school_app/pages/chat/supplier_chat.dart';
import 'package:school_app/services/auth.dart';
import 'chat/chat.dart';

class StartPage extends StatelessWidget with ChangeNotifier {
  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    final BottomNavigationBarProvider NavbarProvider =
        Provider.of<BottomNavigationBarProvider>(context, listen: true);
    final UserState _userState = Provider.of<UserState>(context, listen: true);
    final Auth _auth = Provider.of<Auth>(context);

    final currentTab = [
      SupplierChat(),
      FindSuppliers()
      //Consumer<User>(builder: (_, user, __) => Profile()),
    ];

    final List<BottomNavigationBarItem> bottomNavBarList =
        <BottomNavigationBarItem>[
      //BottomNavigationBarItem(
      //  icon: Icon(Icons.settings),
      //  title: Text("Settings"),
      //),
      //BottomNavigationBarItem(
      //  icon: Icon(Icons.person),
      //  title: Text("Profile"),
      //),
      BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble), title: Text("Chats")),
      BottomNavigationBarItem(icon: Icon(Icons.search), title: Text("Search")),
      //BottomNavigationBarItem(
      //  icon: Icon(Icons.exit_to_app),
      //  title: Text("Logout"),
      //)
    ];

    return Scaffold(
      key: scaffoldKey,
      drawer: HamburgerMenu(),
      body: Stack(
        children: <Widget>[
          currentTab[NavbarProvider.currentIndex],
          Positioned(
            left: 10,
            top: 40,
            child: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => scaffoldKey.currentState.openDrawer(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: NavbarProvider.currentIndex,
        type: BottomNavigationBarType.fixed,
        items: bottomNavBarList,
        onTap: (index) {
          NavbarProvider.currentIndex = index;
          notifyListeners();
        },
      ),
    );
  }
}
