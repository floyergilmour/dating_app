import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:school_app/User/user.dart';
import 'package:school_app/User/userState.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:school_app/services/auth.dart';
import 'package:school_app/components/formState.dart';
import 'package:school_app/extensions/extensions.dart';

class LoginScreen extends StatefulWidget with ChangeNotifier {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password, _name;
  Gender _sexGroupValue = Gender.missing;
  bool _prefersMales  = false, _prefersFemales = false;
  int _age;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    UserState _userState = Provider.of<UserState>(context);
    Auth _auth = Provider.of<Auth>(context);
    User _user = Provider.of<User>(context);
    FormStatus _formState = Provider.of<FormStatus>(context);

    void _moveToLogin({bool resetForm:true}) {
      resetForm ? _formKey.currentState.reset() : null;
      _formState.setFormType = FormType.login;
    }

    void _moveToRegister() {
      _formKey.currentState.reset();
      _formState.setFormType = FormType.register;
    }

    String _pwrValidator(password) {
      Pattern pattern = r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
      RegExp regex = new RegExp(pattern);
      if (!regex.hasMatch(password))
        return 'Invalid password';
      else
        return null;
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

    void _login(e, p) async {
      String returnedUserId = await _auth.signInWithEmailAndPassword(e, p);
      if (returnedUserId.isNotEmpty) {
        _userState.setStatus = UserStatus.Authenticated;
        await _user.setUserSuccessful(returnedUserId);
        //notifyListeners();
      }
    }

    List<Widget> _buildPersonalDetailsInput() {
      return _formState.formType == FormType.login ? []:
       [
        TextFormField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(20.0),
            hintText: "Name",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey),
          ),
          validator: (name) {
            if (name.isEmpty) {
              return 'Please enter a name';
            }
            return null;
          },
          onSaved: (name) => _name = name.trim(),
        ),
        TextFormField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(20.0),
            hintText: "Age",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey),
          ),
          validator: (age) {
            if (int.parse(age) is int && int.parse(age) >= 18 && int.parse(age) < 120) {
              return null;
            }
            return 'Please enter a your age, you must be over 18';
          },
          onSaved: (age) => _age = int.parse(age),
        ),
      ];
    }

    Column _buildTexInputs() {
      return Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(225, 95, 27, .3),
                        blurRadius: 20,
                        offset: Offset(0, 10))
                  ]),
              child: Column(children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: _buildPersonalDetailsInput() + [
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20.0),
                          hintText: "Email or Phone number",
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        validator: (email) => EmailValidator.validate(email)
                            ? null
                            : "Invalid email address",
                        onSaved: (email) => _email = email.trim(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(20.0),
                        ),
                        onSaved: (password) => _password = password,
                        validator: _pwrValidator,
                      ),
                    ],
                  ),
                ),
              ],
              ),
          ),
          SizedBox(height: 20,),
          _formState.formType == FormType.login? Column() :_signupPreferences()
        ],
      );
    }

    Future<void> _validateAndSubmit(BuildContext context) async {
      final formState = _formKey.currentState;
      if (formState.validate()) {
        formState.save();
        try {
          if (_formState.formType == FormType.login) {
            _login(_email, _password);
          } else {
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
        } catch (error) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
            ),
          );
        }
      } else {
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text('Please enter a valid email')));
      }
    }

    Widget _buildSubmitButtons() {
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
              onPressed: () => _validateAndSubmit(context),
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
                : _moveToLogin(resetForm: true);
          },
        )
      ]);
    }

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
                        _buildTexInputs(),
                        SizedBox(
                          height: 50,
                        ),
                        _buildSubmitButtons(),
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
