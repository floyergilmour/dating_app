

import 'package:flutter/material.dart';

import 'constants.dart';

class CustomDefaultTabController extends StatelessWidget {
  List<Tab> tabInput;
  List<Widget> contentInput;
  String title;

  CustomDefaultTabController(this.tabInput, this.contentInput, this.title);

  @override
  Widget build(BuildContext context) {
    return
      DefaultTabController(
      length: tabInput.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: STANDARD_PINK_COLOR,
          elevation: 0,
          bottom: TabBar(
            labelColor: STANDARD_PINK_COLOR,
            unselectedLabelColor:  Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white),
            tabs: tabInput,
          ),
          title: Text(title),
        ),
        body: TabBarView(
          children: contentInput,
        ),
      ),
    );;
  }
}
