import 'package:flutter/material.dart';
import 'package:school_app/components/constants.dart';
import 'package:school_app/components/custom_default_tab_controller.dart';
import 'package:school_app/components/tab_box.dart';
import 'package:school_app/pages/chat/chat.dart';

List<Tab> tabInput = [
  Tab(child: TabBox(Icons.store)),
  Tab(child: TabBox(Icons.local_florist)),
  Tab(child: TabBox(Icons.local_hotel)),
  Tab(child: TabBox(Icons.local_shipping)),
  Tab(child: TabBox(Icons.mail_outline)),
  Tab(child: TabBox(Icons.restaurant_menu)),
];

List<Widget> contentInput = [
  Chat(),
  Chat(),
  Chat(),
  Chat(),
  Chat(),
  Chat(),
];

class SupplierChat extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
      CustomDefaultTabController(tabInput, contentInput, "Supplier chat");
  }
}

