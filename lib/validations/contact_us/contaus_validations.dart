import 'package:email_validator/email_validator.dart';

class ContactUsValidation {
  static fullNameValidation(String value) {
    if (value.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  static mobileNumberValidation(String value) {
    if (value.isEmpty || value.length < 7) {
      return false;
    } else {
      return true;
    }
  }

  static emailValidation(String value) {
    if (value.isEmpty) {
      return false;
    } else {
      EmailValidator.validate(value);

      // RegExp regExp = RegExp(
      //     "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:/.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$");

      return EmailValidator.validate(value);
    }
  }
}
