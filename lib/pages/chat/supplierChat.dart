import 'package:flutter/material.dart';
import 'package:school_app/pages/chat/chat.dart';



class SupplierChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.store, color: Colors.white,)),
                Tab(icon: Icon(Icons.local_florist, color: Colors.white)),
                Tab(icon: Icon(Icons.local_hotel, color: Colors.white )),
                Tab(icon: Icon(Icons.local_shipping, color: Colors.white )),
                Tab(icon: Icon(Icons.mail_outline, color: Colors.white  )),
                Tab(icon: Icon(Icons.restaurant_menu, color: Colors.white  )),
              ],
            ),
            title: Text('Suppliers'),
          ),
          body: TabBarView(
            children: [
              Chat(),
              Chat(),//Icon(Icons.local_florist),
              Chat(),//Icon(Icons.local_hotel),
              Chat(),//Icon(Icons.local_shipping),
              Chat(),//Icon(Icons.mail_outline),
              Chat(),//Icon(Icons.restaurant_menu),
            ],
          ),
        ),
      );
  }
}
