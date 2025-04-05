import 'package:flutter/material.dart';
import 'package:myenglish/core/constants/app_constants.dart';
import 'package:myenglish/core/utils/helpers/textfield_validator.dart';
import 'package:myenglish/core/widgets/toast.dart';
import 'package:myenglish/di/di.dart';
import 'package:myenglish/features/onboarding/domain/usecase/reset_password_usecase.dart';
import 'package:myenglish/features/onboarding/presentation/student/dialogs/password_reset_success_dialog.dart';

class ResetPasswordProvider extends ChangeNotifier {
  final ResetPasswordUseCase _resetPasswordUseCase;
  ResetPasswordProvider(this._resetPasswordUseCase);

  final TextEditingController password = TextEditingController();
  final TextEditingController confPassword = TextEditingController();
  bool passwordError = false;
  bool confPasswordError = false;
  bool hidePassword = true;
  toggleVisibility() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

  bool hideConfPassword = true;
  toggleConfPasswordVisibility() {
    hideConfPassword = !hideConfPassword;
    notifyListeners();
  }

  final formKey = GlobalKey<FormState>();

  checkForErrors() {
    if (TextFieldValidator.newPassword(password.text) == null) {
      passwordError = false;
    } else {
      passwordError = true;
    }
    if (TextFieldValidator.confirmPassword(password.text, confPassword.text) ==
        null) {
      confPasswordError = false;
    } else {
      confPasswordError = true;
    }
    notifyListeners();
  }

  void resetPassword(String email) async {
    checkForErrors();
    if (!passwordError && !confPasswordError) {
      var data = await _resetPasswordUseCase.call(
          email, password.text, appUserMap[getAppUser]!);
      if (data.isLeft()) {
        showToast(data.getLeft().error);
      } else {
        PasswordResetSuccessDialog().show();
      }
    }
  }
}
