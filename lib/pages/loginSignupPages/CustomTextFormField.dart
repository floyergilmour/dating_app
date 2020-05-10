import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final Function validator;
  final Function onSaved;
  final bool obscureText;

  CustomTextFormField({this.hint, this.validator, this.onSaved, this.obscureText=false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20.0),
        hintText: hint,
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.grey),
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }


}

