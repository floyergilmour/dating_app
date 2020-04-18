import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

enum FormType {
  login,
  register,
}

class FormStatus extends ChangeNotifier{
  FormType _formType = FormType.login;

  FormType get formType => _formType;

  set setFormType(FormType f) {
    _formType = f;
    notifyListeners();
  }
}
