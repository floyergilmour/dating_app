import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final Function onChanged;
  CustomTextField({
    this.hint, this.controller, this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
        border: InputBorder.none,
      ),
      style: TextStyle(fontSize: 20),
    );
  }


}

