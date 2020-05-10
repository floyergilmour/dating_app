import 'dart:math';

import 'package:flutter/material.dart';
import 'package:school_app/User/user.dart';
import 'package:school_app/User/userState.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:school_app/pages/loginSignupPages/submitButtons.dart';
import 'package:school_app/pages/loginSignupPages/texInputs.dart';
import 'package:school_app/services/auth.dart';
import 'package:school_app/components/formState.dart';
import 'package:school_app/services/formKey.dart';

class LoginScreen extends StatefulWidget with ChangeNotifier {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password, _name;
  Gender _sexGroupValue = Gender.missing;
  bool _prefersMales  = false, _prefersFemales = false;
  int _age;
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    UserState _userState = Provider.of<UserState>(context);
    Auth _auth = Provider.of<Auth>(context);
    User _user = Provider.of<User>(context);
    FormStatus _formState = Provider.of<FormStatus>(context);
    FormKey _formKey = Provider.of<FormKey>(context);
    /*
    var validator = Validators();

    void _moveToLogin({bool resetForm:true}) {
      resetForm ? _formKey.reset() : null;
      _formState.setFormType = FormType.login;
    }

    void _moveToRegister() {
      _formKey.reset();
      _formState.setFormType = FormType.register;
    }


    Widget _checkbox(String title, bool boolValue) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title),
          Checkbox(
            value: boolValue,
            onChanged: (bool value) {
              setState(() {
                switch (title) {
                  case "Males":
                    _prefersMales = value;
                    break;
                  case "Females":
                    _prefersFemales = value;
                    break;
                }
              });
            },
          )
        ],
      );
    }

    Widget _radio(String title, dynamic value, dynamic groupValue) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title),
          Radio(
            value: value,
            groupValue: _sexGroupValue,
            onChanged: (value) {
              setState((){
                _sexGroupValue = value;
              });
              print(value);
            },
          )
        ],
      );
    }



    Container _signupPreferences() {
      return Container(
        padding: EdgeInsets.fromLTRB(20, 20, 5, 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(225, 95, 27, .3),
                  blurRadius: 20,
                  offset: Offset(0, 10))
            ]),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text("I am a", style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    _radio("Male", Gender.male, _sexGroupValue),
                    _radio("Female", Gender.female, _sexGroupValue),
                  ],
                ),
              ]
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text("I would like to meet", style: TextStyle(fontWeight: FontWeight.bold),)),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    _checkbox("Males", _prefersMales),
                    _checkbox("Females", _prefersFemales)
                  ],
                )
              ],
            )
          ],
        ),
      );
    }
*/
    /*
    showSnack(String message,BuildContext context){
      return Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }

    void login(e, p) async {
      String returnedUserId = await _auth.signInWithEmailAndPassword(e, p);
      if (returnedUserId.isNotEmpty) {
        _userState.setStatus = UserStatus.Authenticated;
        await _user.setUserSuccessful(returnedUserId);
      }
    }

     */

    /*
    void register(e, p) async {
      String newUserId = await _auth.createUserWithEmailAndPassword(_email, _password);

      var gender = _sexGroupValue.toShortString();
      var genderPreferences = [
        _prefersMales? Gender.male.toShortString():null,
        _prefersFemales? Gender.female.toShortString():null
      ].where((x) => x != null).toList();

      _auth.updateValues(
          newUserId,
          {
            "name": _name,
            "age": _age,
            "gender": gender,
            "gender_preferences" : genderPreferences
          });
      _moveToLogin(resetForm: false);
    }
     */

    /*
    Future<void> _validateAndSubmit(BuildContext context) async {
      if (_formKey.validate()) {
        _formKey.save();
        try {
          _formState.formType == FormType.login
              ? login(_email, _password)
              : register( _email, _password);
        } catch (error) {
          showSnack(error.toString(), context);
        }
      } else {
        showSnack("Please enter a valid credentials", context);
      }
    }
    */

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: _formState.formType == FormType.register ? [
              Color.fromRGBO(250, 128, 128, 1),
              Color.fromRGBO(150, 247, 210, 1),
            ] :
            [
              Color.fromRGBO(150, 247, 210, 1),
              Color.fromRGBO(250, 128, 128, 1),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _formState.formType == FormType.login ? "Hello, welcome back!" : "Signup",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 0,
                          color: Colors.black,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        //_buildTexInputs(),
                        TextInputs(
                          onSavedEmail: (email) => _email = email.trim(),
                          onSavedPassword: (pwd) => _password = pwd,
                          onSavedName: (name) => _name = name.trim(),
                          onSavedAge: (age) => _age = int.parse(age),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        //_buildSubmitButtons(),
                        SubmitButtons(
                          //validateAndSubmit: _validateAndSubmit,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.grey),
                        ),
                        //socialMediaButtons()
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
