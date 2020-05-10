import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/user/userSignUpLoginData.dart';
import 'package:school_app/user/user.dart';

class SignupPreferences extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserSignUpLoginData _loginData = Provider.of<UserSignUpLoginData>(context);

    Widget _checkbox(String title, bool boolValue) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title),
          Checkbox(
            value: boolValue,
            onChanged: (bool likes)
                {_loginData.setGenderPreferences(title, likes);
                print(_loginData.genderPreferences);
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
            groupValue: groupValue,
            onChanged: (val) => _loginData.setGender = val,
          )
        ],
      );
    }


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
          Row(children: [
            Expanded(
              flex: 1,
              child: Text(
                "I am a",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                _radio("Male", Gender.male, _loginData.gender),
                _radio("Female", Gender.female, _loginData.gender),
              ],
            ),
          ]),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    "I would like to meet",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  _checkbox("Males", _loginData.genderPreferences.contains("Males")),
                  _checkbox("Females", _loginData.genderPreferences.contains("Females"))
                ],
              )
            ],
          )
        ],
      ),
    );
    ;
  }
}
