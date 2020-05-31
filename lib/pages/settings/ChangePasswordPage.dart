import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/pages/loginSignupPages/validators.dart';
import 'package:school_app/services/auth.dart';

class ChangePasswordPage extends StatelessWidget {
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();
  var validator = Validators();
  final TextEditingController _oldPwdController = new TextEditingController();
  final TextEditingController _newPwdController1 = new TextEditingController();
  final TextEditingController _newPwdController2 = new TextEditingController();

  Widget _buildPasswordCard(
      String hint, bool obscureText, TextEditingController controller) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 300.0,
        ),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          onChanged: (value) {
            print(value);
          },
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            border: InputBorder.none,
          ),
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Auth _auth = Provider.of<Auth>(context);
    return Container(
      child: Column(
        children: [
          Form(
            key: _passwordFormKey,
            child: Column(
              children: <Widget>[
                _buildPasswordCard(
                    "Existing password", true, _oldPwdController),
                _buildPasswordCard("New password", true, _newPwdController1),
                _buildPasswordCard("Repeat password", true, _newPwdController2),
              ],
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Center(
            child: Builder(
              builder: (context) => ButtonTheme(
                height: 50,
                minWidth: 150,
                child: RaisedButton(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  onPressed: () {
                    final state = _passwordFormKey.currentState;
                    //_updateProfileInformation();
                    if (state.validate()) {
                      state.save();
                      try {
                        validator.changePasswordValidator(
                            _oldPwdController.text,
                            _newPwdController1.text,
                            _newPwdController2.text);

                        _auth
                            .changePassword(_newPwdController1.text)
                            .then((_) => Navigator.pop(context))
                            .catchError((error) {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text("pre catch: "+error.toString()),
                            ),
                          );
                        });

                      } catch (error) {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text(error.toString()),
                          ),
                        );
                      }
                    } else {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Please enter matching password that is different from your old password"),
                        ),
                      );
                    }
                  },
                  color: Color.fromRGBO(250, 150, 150, 1),
                  //Color.fromRGBO(150, 247, 210, 1),
                  textColor: Colors.white,
                  child: Text(
                    "Save changes",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
