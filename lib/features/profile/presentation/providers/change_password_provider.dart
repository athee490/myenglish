import 'package:flutter/material.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/utils/helpers/textfield_validator.dart';
import 'package:myenglish/core/widgets/toast.dart';
import 'package:myenglish/features/profile/domain/usecase/change_password_usecase.dart';
import 'package:myenglish/main.dart';

class ChangePasswordProvider extends ChangeNotifier {
  final ChangePasswordUseCase _changePasswordUseCase;
  ChangePasswordProvider(this._changePasswordUseCase);

  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confPassword = TextEditingController();
  bool oldPasswordError = false;
  bool passwordError = false;
  bool confPasswordError = false;
  final formKey = GlobalKey<FormState>();

  ///password visibility-------------
  bool hidePassword = true;
  toggleVisibility() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

  bool hideNewPassword = true;
  toggleNewPasswordVisibility() {
    hideNewPassword = !hideNewPassword;
    notifyListeners();
  }

  bool hideConfPassword = true;
  toggleConfPasswordVisibility() {
    hideConfPassword = !hideConfPassword;
    notifyListeners();
  }

  ///-----------------------------------

  checkForErrors() {
    if (TextFieldValidator.password(oldPassword.text) == null) {
      oldPasswordError = false;
    } else {
      oldPasswordError = true;
    }
    if (TextFieldValidator.newPassword(newPassword.text) == null) {
      passwordError = false;
    } else {
      passwordError = true;
    }
    if (TextFieldValidator.confirmPassword(
            newPassword.text, confPassword.text) ==
        null) {
      confPasswordError = false;
    } else {
      confPasswordError = true;
    }
    notifyListeners();
  }

  void resetPassword() async {
    checkForErrors();
    if (!passwordError && !confPasswordError && !oldPasswordError) {
      FocusManager.instance.primaryFocus?.unfocus();
      var data = await _changePasswordUseCase.call(
          oldPassword: oldPassword.text, newPassword: newPassword.text);
      if (data.isLeft()) {
        showToast(data.getLeft().error, type: ToastType.error);
      } else {
        showToast('Password Reset Successfully', type: ToastType.success);
        Navigator.pop(navigatorKey.currentContext!);
      }
    }
  }
}
