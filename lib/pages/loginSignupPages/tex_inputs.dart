import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/components/form_state.dart';
import 'package:school_app/pages/loginSignupPages/custom_text_form_field.dart';
import 'package:school_app/pages/loginSignupPages/signup_preferences.dart';
import 'package:school_app/pages/loginSignupPages/validators.dart';
import 'package:school_app/services/form_key.dart';
import 'package:school_app/user/user_sign_up_login_data.dart';

class TextInputs extends StatelessWidget with ChangeNotifier {
  Widget build(BuildContext context) {
    FormStatus _formState = Provider.of<FormStatus>(context);
    FormKey _formKey = Provider.of<FormKey>(context);
    UserSignUpLoginData _signupData = Provider.of<UserSignUpLoginData>(context);
    var validator = Validators();

    List<Widget> _buildPersonalDetailsInput() {
      return _formState.formType == FormType.login
          ? []
          : [
              CustomTextFormField(
                hint: "Name",
                validator: (value) => validator.nameValidator(value),
                onSaved: (value) => _signupData.setName = value.trim(),
              ),
              CustomTextFormField(
                hint: "Age",
                validator: (value) => validator.ageValidator(value),
                onSaved: (value) => _signupData.setAge = int.parse(value),
              ),
            ];
    }

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
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey.formKey,
                child: Column(
                  children: _buildPersonalDetailsInput() +
                      [
                        CustomTextFormField(
                          hint: "Email or Phone number",
                          validator: (value) => validator.emailValidator(value),
                          onSaved: (value) =>
                              _signupData.setEmail = value.trim(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          obscureText: true,
                          hint: "Password",
                          validator: (value) =>
                              validator.passwordValidator(value),
                          onSaved: (value) => _signupData.setPassword = value,
                        ),
                      ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        _formState.formType == FormType.login ? Column() : SignupPreferences()
      ],
    );
  }
}
