import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/components/formState.dart';
import 'package:school_app/pages/loginSignupPages/UserSignUpLoginData.dart';
import 'package:school_app/services/auth.dart';
import 'package:school_app/services/formKey.dart';
import 'package:school_app/user/user.dart';
import 'package:school_app/user/userState.dart';

class SubmitButtons extends StatelessWidget {

  //Function validateAndSubmit;

  //SubmitButtons({this.validateAndSubmit});

  @override
  Widget build(BuildContext context) {
    FormKey _formKey = Provider.of<FormKey>(context);
    FormStatus _formState = Provider.of<FormStatus>(context);
    Auth _auth = Provider.of<Auth>(context);
    UserSignUpLoginData _signupData = Provider.of<UserSignUpLoginData>(context);
    UserState _userState = Provider.of<UserState>(context);
    User _user = Provider.of<User>(context);

    void _moveToLogin({bool resetForm:true}) {
      resetForm ? _formKey.reset() : null;
      _formState.setFormType = FormType.login;
    }

    void _moveToRegister() {
      _formKey.reset();
      _formState.setFormType = FormType.register;
    }
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

    void register(e, p) async {
      String newUserId = await _auth.createUserWithEmailAndPassword(_signupData.email, _signupData.password);
      _auth.updateValues(
          newUserId,
          {
            "name": _signupData.name,
            "age": _signupData.age,
            "gender": _signupData.gender,
            "gender_preferences" : _signupData.genderPreferences
          });
      _moveToLogin(resetForm: false);
    }

    Future<void> validateAndSubmit(BuildContext context) async {
      if (_formKey.validate()) {
        _formKey.save();
        try {
          _formState.formType == FormType.login
              ? login(_signupData.email, _signupData.password)
              : register( _signupData.email, _signupData.password);
        } catch (error) {
          showSnack(error.toString(), context);
        }
      } else {
        showSnack("Please enter a valid credentials", context);
      }
    }
    return Column(children: [
      Builder(
        builder: (context) => ButtonTheme(
          height: 50,
          minWidth: 150,
          child: RaisedButton(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            onPressed: () => validateAndSubmit(context),
            color: _formState.formType == FormType.register ? Color.fromRGBO(250, 150, 150, 1) : Color.fromRGBO(150, 247, 210, 1),
            textColor: Colors.white,
            child: _formState.formType == FormType.login
                ? Text(
              "LOGIN",
              style: TextStyle(fontSize: 14),
            )
                : Text(
              "REGISTER",
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 50,
      ),
      InkWell(
        splashColor: Colors.yellow,
        hoverColor: Colors.red,
        highlightColor: Colors.blue,
        child: _formState.formType == FormType.login
            ? Text("Register new account",
            style: TextStyle(color: Colors.grey))
            : Text("Login to existing account", style: TextStyle(color: Colors.grey)),
        onTap: () {
          _formState.formType == FormType.login
              ? _moveToRegister()
              : _moveToLogin();
        },
      )
    ]);
  }

}
