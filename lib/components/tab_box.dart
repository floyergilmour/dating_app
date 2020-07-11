import 'package:flutter/material.dart';

class TabBox extends StatelessWidget {
  IconData icon;
  double borderRadius = 50.0;
  Color borderColor = const Color.fromRGBO(150, 247, 210, 1);
  double borderWidth = 1.0;

  TabBox(this.icon, {this.borderRadius, this.borderColor, this.borderWidth});
  
  @override
  Widget build(BuildContext context) {
    return 
       Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          //border: Border.all(color: borderColor, width: borderWidth)
        ),
        child: Align(
          alignment: Alignment.center,
          child: Icon(icon),
        ),
      );
    
  }
}
