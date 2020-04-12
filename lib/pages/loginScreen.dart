import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:school_app/User/user_2.dart';
import 'package:school_app/start_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:school_app/User/auth.dart';

enum FormType {
  login,
  register,
}

class LoginScreen extends StatelessWidget with ChangeNotifier {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    UserState2 userState = Provider.of<UserState2>(context);
    Auth _auth = Provider.of<Auth>(context);


    Future<void> signIn(BuildContext context) async {
      final formState = _formKey.currentState;

      if (formState.validate()) {
        formState.save();

        try// (await user.signIn(_email, _password)){
          {
          print(DateTime.now().toString() + ": loginScreen.dart : signIn() : email="+_email);
          print(DateTime.now().toString() + ": loginScreen.dart : signIn() : password="+_password);
          String user = await _auth.signInWithEmailAndPassword(_email, _password);
          if(user.isNotEmpty){
            userState.setStatus = UserStatus2.Authenticated;
            notifyListeners();
          }
          print(DateTime.now().toString() + ": loginScreen.dart: signIn() : Pressed login and successfully logged in!!");
          print(DateTime.now().toString() + ": loginScreen.dart: signIn() : user.status: "+user);
        } catch(error) {
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text(error.toString()),),
          );
        }
      }
      else {
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text('Please enter a valid email')));
      }
    }


    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              // https://colorsinspo.com/
              Color.fromRGBO(250, 128, 128, 1),
              Color.fromRGBO(150, 247, 210, 1),
            ])),
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
                    "Hello, welcome back!",
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
                    topLeft: Radius.circular(60),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 60,),
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
                            child: Column(
                              children: <Widget>[
                                Form(
                                    key: _formKey,
                                    child: Column(children: <Widget>[
                                      TextFormField(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(20.0),
                                          hintText: "Email or Phone number",
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                              color: Colors.grey),
                                        ),
                                        validator: (email) =>
                                        EmailValidator.validate(email)
                                            ? null
                                            : "Invalid email address",
                                        onSaved: (email) => _email = email,
                                      ),
                                      SizedBox(height: 10,),
                                      TextFormField(
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                              color: Colors.grey),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(20.0),
                                        ),
                                        onSaved: (password) =>
                                        _password = password,
                                        validator: (password) {
                                          Pattern pattern = r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                                          RegExp regex = new RegExp(pattern);
                                          if (!regex.hasMatch(password))
                                            return 'Invalid password';
                                          else
                                            return null;
                                          },
                                      ),
                                    ])),
                              ],
                            )),
                        SizedBox(height: 40,),
                        Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 40,),
                        //user.status == UserStatus.Authenticating
                        //    ? Center(child: CircularProgressIndicator()):
                        Builder(
                          builder: (context) => ButtonTheme(
                            height: 50,
                            minWidth: 150,
                            child: RaisedButton(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              onPressed: () => signIn(context),
                              color: Color.fromRGBO(250, 150, 150, 1),
                              textColor: Colors.white,
                              child: Text(
                                "LOGIN",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 50,),
                        Text(
                            "Continue with social media",
                            style: TextStyle(color: Colors.grey)),
                        SizedBox(
                          height: 50,
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