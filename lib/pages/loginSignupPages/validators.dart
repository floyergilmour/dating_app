import 'package:email_validator/email_validator.dart';

class Validators {
  String ageValidator(value) {
    if (value == null) {
      return 'Please enter a your age, you must be over 18';
    } else if (int.parse(value) is int &&
        int.parse(value) >= 18 &&
        int.parse(value) < 120) {
      return null;
    }
    return 'Please enter a your age, you must be over 18';
  }

  String nameValidator(value) {
    return value.isEmpty ? 'Please enter a name' : null;
  }

  String emailValidator(value) {
    return EmailValidator.validate(value) ? null : "Invalid email address";
  }

  String passwordValidator(value) {
    Pattern pattern = r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Invalid password';
    else
      return null;
  }
}
