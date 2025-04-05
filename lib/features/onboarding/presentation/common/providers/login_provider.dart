import 'package:flutter/material.dart';
import 'package:myenglish/core/config/app_routes.dart';
import 'package:myenglish/core/constants/app_constants.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/utils/helpers/textfield_validator.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/core/widgets/toast.dart';
import 'package:myenglish/di/di.dart';
import 'package:myenglish/features/onboarding/domain/usecase/send_otp_usecase.dart';
import 'package:myenglish/features/onboarding/domain/usecase/student_login_usecase.dart';
import 'package:myenglish/features/onboarding/domain/usecase/tutor_login_usecase.dart';
import 'package:myenglish/features/onboarding/domain/usecase/update_devicetoken_usecase.dart';
import 'package:myenglish/main.dart';

class LoginProvider extends ChangeNotifier {
  final StudentLoginUseCase _studentLoginUseCase;
  final TutorLoginUseCase _tutorLoginUseCase;
  final UpdateDeviceTokenUseCase _updateDeviceTokenUseCase;
  final SendOtpUseCase _sendOtpUseCase;
  bool hidePassword = true;

  toggleVisibility() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

  LoginProvider(this._studentLoginUseCase, this._tutorLoginUseCase,
      this._updateDeviceTokenUseCase, this._sendOtpUseCase) {
    email.addListener(() {
      if (email.text.length > 3 && password.text.length > 3) {
        buttonEnabled = true;
      } else {
        buttonEnabled = false;
      }
      notifyListeners();
    });
    password.addListener(() {
      if (email.text.trim().length > 3 && password.text.trim().length > 3) {
        buttonEnabled = true;
      } else {
        buttonEnabled = false;
      }
      notifyListeners();
    });
  }

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool passwordError = false;
  bool buttonEnabled = false;
  final formKey = GlobalKey<FormState>();

  checkForErrors() {
    if (TextFieldValidator.password(password.text.trim()) == null) {
      passwordError = false;
    } else {
      passwordError = true;
    }
    notifyListeners();
  }

  void submit() {
    checkForErrors();
    if (!formKey.currentState!.validate() || passwordError) return;
    FocusManager.instance.primaryFocus?.unfocus();
    if (getAppUser == AppUser.student) {
      print(getAppUser);
      studentLogin();
    } else if (getAppUser == AppUser.tutor) {
      print(getAppUser);
      tutorLogin();
    }
  }

  void studentLogin() async {
    var data =
        await _studentLoginUseCase.call(email.text, password.text.trim());
    if (data.isLeft()) {
      if (data.getLeft().error.toString().toLowerCase().contains('suspended')) {
        await Navigator.pushNamed(
            navigatorKey.currentContext!, AppRoutes.accountSuspended,
            arguments: {'isFromLogin': true});
      } else {
        showToast(data.getLeft().error,
            backgroundColor: Colors.red, textColor: Colors.white);
      }
    } else {
      await Prefs().setBool(Prefs.isLoggedIn, true);
      await Prefs().setString(Prefs.email, email.text);
      await Prefs().setString(Prefs.token, data.getRight());
      await Prefs().setString(Prefs.userType, AppStrings.student);
      _updateDeviceTokenUseCase
          .call(Prefs().getString(Prefs.fcmDeviceToken) ?? '');
      showToast(
        'Login Successful',
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!,
          AppRoutes.studentHome, (route) => false);
    }
  }

  void tutorLogin() async {
    var data = await _tutorLoginUseCase.call(email.text, password.text);
    if (data.isLeft()) {
      if (data.getLeft().error.toString().toLowerCase().contains('suspended')) {
        Navigator.pushNamed(
            navigatorKey.currentContext!, AppRoutes.accountSuspended,
            arguments: {'isFromLogin': true});
      } else {
        showToast(
          data.getLeft().error,
        );
      }
    } else {
      await Prefs().setBool(Prefs.isLoggedIn, true);
      await Prefs().setString(Prefs.email, email.text);
      await Prefs().setString(Prefs.token, data.getRight());
      await Prefs().setString(Prefs.userType, AppStrings.tutor);
      _updateDeviceTokenUseCase
          .call(Prefs().getString(Prefs.fcmDeviceToken) ?? '');
      showToast(
        'Login Successful',
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!,
          AppRoutes.tutorHomeTab, (route) => false);
    }
  }

  sendOtp() async {
    if (email.text.trim().isEmpty) {
      showToast('Please enter email');
      return;
    }
    if (TextFieldValidator.email(email.text) != null) {
      showToast('Enter valid email');
      return;
    }
    var data = await _sendOtpUseCase.call(email.text, appUserMap[getAppUser]!);
    if (data.isLeft()) {
      showToast(data.getLeft().error);
    } else {
      showToast('OTP sent. Please check your email');
      Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.otp,
          arguments: {
            'email': email.text,
            'otp': data.getRight(),
          });
    }
  }
}
