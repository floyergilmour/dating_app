import 'package:flutter/material.dart';

import 'CutomListViewBuilder.dart';

class FindOtherUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.store)),
                Tab(icon: Icon(Icons.local_florist)),
                Tab(icon: Icon(Icons.local_hotel )),
                Tab(icon: Icon(Icons.local_shipping )),
                Tab(icon: Icon(Icons.mail_outline  )),
                Tab(icon: Icon(Icons.restaurant_menu  )),
              ],
            ),
            title: Text('Suppliers'),
          ),
          body: TabBarView(
            children: [
              CustomListViewBuilder(),
              //Icon(Icons.local_florist),
              Icon(Icons.local_florist),
              Icon(Icons.local_hotel),
              Icon(Icons.local_shipping),
              Icon(Icons.mail_outline),
              Icon(Icons.restaurant_menu),
            ],
          ),
        ),
      );
  }
}
