import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;

  CustomRaisedButton({this.buttonText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 50,
      minWidth: 150,
      child: RaisedButton(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        onPressed: onPressed,
        color: Color.fromRGBO(250, 150, 150, 1),
        textColor: Colors.white,
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
