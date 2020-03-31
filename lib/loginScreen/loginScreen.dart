import 'package:school_app/Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';

class loginScreen extends StatefulWidget {
  loginScreen({Key key}) : super(key: key);

  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.teal[900],
                  Colors.teal[800],
                  Colors.teal[400]
                ]
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80,),
            welcomeMessage(),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60))
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 60,),
                        loginInput(),
                        SizedBox(height: 40,),
                        FadeAnimation(1.5, Text("Forgot Password?", style: TextStyle(color: Colors.grey),)),
                        SizedBox(height: 40,),
                        loginButton(),
                        SizedBox(height: 50,),
                        FadeAnimation(1.7, Text("Continue with social media", style: TextStyle(color: Colors.grey),)),
                        SizedBox(height: 50,),
                        socialMediaButtons()
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


class loginInput extends StatelessWidget {
  loginInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      FadeAnimation(1.4, Container(
          decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(
              color: Color.fromRGBO(225, 95, 27, .3),
              blurRadius: 20,
              offset: Offset(0, 10)
          )]
      ),
child:      Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[200]))
          ),
          child: TextField(
            decoration: InputDecoration(
                hintText: "Email or Phone number",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[200]))
          ),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Password",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    )));
  }
}


class socialMediaButtons extends StatelessWidget {
  socialMediaButtons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[

        Expanded(
          child: FadeAnimation(1.9, Container(
            height: 50,
            child: Center(
                child: GestureDetector( child: Image.asset("/Users/donnyh/code/school_app/assets/icons/facebook_logo.png"), onTap: (){},)
            ),
          )),
        ),
        SizedBox(width: 10,),
        Expanded(
          child: FadeAnimation(1.9, Container(
            height: 50,
            child: Center(
                child: Image.asset("/Users/donnyh/code/school_app/assets/icons/google_logo.png")
            ),
          )),
        ),
      ],
    );
  }
}



class loginButton extends StatelessWidget {
  loginButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    FadeAnimation(1.6, Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.teal[700]
      ),
      child: Center(
        child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
    ));
  }
}




class welcomeMessage extends StatelessWidget {
  welcomeMessage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FadeAnimation(1, Text("Login", style: TextStyle(color: Colors.white, fontSize: 40),)),
            SizedBox(height: 10,),
            FadeAnimation(1.3, Text("Welcome Back", style: TextStyle(color: Colors.white, fontSize: 18),)),
          ],
        ),
      );
  }
}

