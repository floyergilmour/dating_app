import 'package:email_validator/email_validator.dart';

class Validators {
  RegExp regex =
      new RegExp(r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$');

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
    if (!regex.hasMatch(value))
      return 'Invalid password';
    else
      return null;
  }

  String changePasswordValidator(
      String oldPass, String newPass1, String newPass2) {
    if (newPass1 == newPass2 &&
        oldPass != newPass1 &&
        oldPass != newPass2 &&
        !regex.hasMatch(newPass1)) {
      return null;
    } else if (newPass1 != newPass2) {
      return throw ("New passwords do not match");
    } else if ([newPass1,newPass2].contains(oldPass)) {
      return throw ("Old password and new must be different");
    } else
      return throw ("Something went wrong please try again");
  }
}
