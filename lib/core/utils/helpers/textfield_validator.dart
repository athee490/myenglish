import 'package:myenglish/core/utils/helpers/app_helpers.dart';

class TextFieldValidator {
  static String? email(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    bool isValid = RegExp(r'^[\w\.-]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email ?? '');
    return isValid ? null : 'Invalid email';
  }

  static String? password(String? password) {
    if (password!.trim().isEmpty) {
      return 'Password required';
    }
    bool isValid = password.trim().length > 4 ? true : false;
    return isValid ? null : 'Invalid password';
  }

  static String? newPassword(String? password) {
    if (password!.isEmpty) {
      return 'Password required';
    }
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
    if (password.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(password)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }

  static String? confirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return 'Field required';
    }
    if (password != confirmPassword) {
      return 'Password doesn\'t match';
    }
    return null;
  }

  static String? pincode(String? s) {
    if (s!.length >= 7 || s.isEmpty || !checkNumeric(s)) {
      return 'Pincode must be 6 digits';
    }
    return null;
  }

  static String? mobileNo(String? s) {
    if (s!.length != 10 || !checkNumeric(s)) {
      return 'Phone number should be 10 digits';
    }
    return null;
  }

  static String? name(String? s) {
    if (s!.trim().length < 2) {
      return 'Provide valid name';
    }
    return null;
  }

  static String? fieldRequired(String? s) {
    if (s!.isEmpty) {
      return 'Field required';
    }
    return null;
  }

  static String? title(String? s) {
    if (s!.isEmpty) {
      return 'Provide title';
    }
    return null;
  }

  static String? price(String? s) {
    if (s!.isEmpty) {
      return 'Provide price';
    }
    return null;
  }

  static String? description(String? s) {
    if (s!.isEmpty) {
      return 'Provide description';
    }
    return null;
  }


  static String? accNo(String? s) {
    if (s!.trim().isNotEmpty) {
      if (s.length < 9 || s.length > 18) {
        return 'Enter valid Account Number';
      }
    } else {
      return 'Field required';
    }
    return null;
  }
}
