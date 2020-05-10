import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FormKey extends ChangeNotifier {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey get formKey => _formKey;
  State<StatefulWidget> get currentState => _formKey.currentState;

  void reset(){
    _formKey.currentState.reset();
    notifyListeners();
  }

  void save(){
    _formKey.currentState.save();
    notifyListeners();
  }

  bool validate(){
    return _formKey.currentState.validate();
  }
}
