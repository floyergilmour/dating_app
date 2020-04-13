import 'package:school_app/User/user.dart';

extension StringExtension on String {
  String capitalize() {
    if(this.length == 0){
      return "";
    }
    else{
    return "${this[0].toUpperCase()}${this.substring(1)}";
    }
  }
}
extension GenderExtension on Gender {
  String toShortString() {
    String genderString = this.toString().split('.').last;
    return genderString.capitalize();
  }
}

extension UserTypeExtension on UserType {
  String toShortString() {
    String genderString = this.toString().split('.').last;
    return genderString.capitalize();
  }
}
