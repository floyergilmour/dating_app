import 'package:flutter/material.dart';
import 'package:school_app/components/customTextField.dart';


class CustomInputCard extends StatelessWidget {

  final List<CustomTextField> textFields;

  CustomInputCard({
    this.textFields
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Column(
        children: textFields,
      ),
    );
  }
}
