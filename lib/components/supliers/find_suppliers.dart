import 'package:flutter/material.dart';
import 'package:school_app/components/custom_default_tab_controller.dart';
import 'package:school_app/components/tab_box.dart';

import 'supplier_cards.dart';
List<Tab> tabInput = [
  Tab(child: TabBox(Icons.store)),
  Tab(child: TabBox(Icons.local_florist)),
  Tab(child: TabBox(Icons.local_hotel)),
  Tab(child: TabBox(Icons.local_shipping)),
  Tab(child: TabBox(Icons.mail_outline)),
  Tab(child: TabBox(Icons.restaurant_menu)),
];

List<Widget> contentInput = [
  CustomListViewBuilder(),
  CustomListViewBuilder(),
  CustomListViewBuilder(),
  CustomListViewBuilder(),
  CustomListViewBuilder(),
  CustomListViewBuilder(),
];

class FindSuppliers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      CustomDefaultTabController(tabInput, contentInput, "Explore Supplier");
  }
}
