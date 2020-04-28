import 'package:flutter/material.dart';


class BuildDivider extends StatefulWidget {
  @override
  BuildDividerState createState() => BuildDividerState();
}

class BuildDividerState extends State<BuildDivider> {

  int height = 1;
  BuildDividerState([this.height=1]);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      height: 1,
      color: Colors.grey.shade400,
    );
  }
}
