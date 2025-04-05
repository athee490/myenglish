import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/utils/helpers/textfield_validator.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/button.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/core/widgets/dialog.dart';
import 'package:myenglish/core/widgets/textfield.dart';
import 'package:myenglish/di/di.dart';
import 'package:myenglish/main.dart';
import 'package:resize/resize.dart';

class ChangePasswordDialog extends CustomDialog {
  ChangePasswordDialog();

  @override
  Widget getChild() {
    return Consumer(builder: (context, ref, _) {
      var mResetPasswordProvider = ref.watch(changePasswordProvider);
      return Stack(
        children: [
          Container(
              // width: 90.vw,
              padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 25.w),
              child: SingleChildScrollView(
                child: Form(
                  key: mResetPasswordProvider.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(
                        AppStrings.resetPassword,
                        fontWeight: FontWeight.w700,
                        textSize: 20.sp,
                      ),
                      vHeight(34.h),
                      PasswordTextField(
                        label: AppStrings.oldPassword,
                        obscureText: mResetPasswordProvider.hidePassword,
                        toggleVisibility: () =>
                            mResetPasswordProvider.toggleVisibility(),
                        controller: mResetPasswordProvider.oldPassword,
                        validator: TextFieldValidator.password,
                        hasError: mResetPasswordProvider.oldPasswordError,
                        errorText: TextFieldValidator.password(
                            mResetPasswordProvider.oldPassword.text),
                      ),
                      vHeight(18.h),
                      PasswordTextField(
                        label: AppStrings.newPassword,
                        obscureText: mResetPasswordProvider.hideNewPassword,
                        toggleVisibility: () => mResetPasswordProvider
                            .toggleNewPasswordVisibility(),
                        controller: mResetPasswordProvider.newPassword,
                        validator: TextFieldValidator.newPassword,
                        hasError: mResetPasswordProvider.passwordError,
                        errorText: TextFieldValidator.newPassword(
                            mResetPasswordProvider.newPassword.text),
                      ),
                      vHeight(18.h),
                      PasswordTextField(
                        label: AppStrings.confirmPassword,
                        obscureText: mResetPasswordProvider.hideConfPassword,
                        toggleVisibility: () => mResetPasswordProvider
                            .toggleConfPasswordVisibility(),
                        controller: mResetPasswordProvider.confPassword,
                        validator: (s) => TextFieldValidator.confirmPassword(
                            mResetPasswordProvider.newPassword.text,
                            mResetPasswordProvider.confPassword.text),
                        hasError: mResetPasswordProvider.confPasswordError,
                        errorText: TextFieldValidator.confirmPassword(
                            mResetPasswordProvider.newPassword.text,
                            mResetPasswordProvider.confPassword.text),
                      ),
                      vHeight(12.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AppText(
                          AppStrings.note,
                          textSize: 12.sp,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AppText(
                          AppStrings.passwordNote,
                          textSize: 10.sp,
                          lineHeight: 1.8,
                          textColor: AppColors.grey79,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      vHeight(56.h),
                      PrimaryAppButton(
                        title: AppStrings.confirmPassword.toUpperCase(),
                        onTap: () {
                          mResetPasswordProvider.resetPassword();
                        },
                      ),
                    ],
                  ),
                ),
              )),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.close,
                color: AppColors.greyC3,
                size: 22.5.h,
              ),
            ),
          )
        ],
      );
    });
  }

  @override
  void show() {
    super.showDialog(navigatorKey.currentContext!);
  }
}
