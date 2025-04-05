import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/utils/helpers/textfield_validator.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/button.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/core/widgets/textfield.dart';
import 'package:myenglish/di/di.dart';
import 'package:myenglish/features/onboarding/presentation/common/widgets/auth_scaffold.dart';
import 'package:resize/resize.dart';

class ResetPasswordScreen extends ConsumerWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context, ref) {
    var mResetPasswordProvider = ref.watch(resetPasswordProvider);
    return WillPopScope(
      onWillPop: () async => false,
      child: AuthScaffold(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Form(
          key: mResetPasswordProvider.formKey,
          child: Column(
            children: [
              vHeight(106.h),
              AppText(
                AppStrings.resetPassword,
                fontWeight: FontWeight.w700,
                textSize: 20.sp,
              ),
              vHeight(34.h),
              PasswordTextField(
                label: AppStrings.password,
                obscureText: mResetPasswordProvider.hidePassword,
                toggleVisibility: () =>
                    mResetPasswordProvider.toggleVisibility(),
                controller: mResetPasswordProvider.password,
                validator: TextFieldValidator.newPassword,
                hasError: mResetPasswordProvider.passwordError,
                errorText: TextFieldValidator.newPassword(
                    mResetPasswordProvider.password.text),
              ),
              vHeight(18.h),
              PasswordTextField(
                label: AppStrings.confirmPassword,
                obscureText: mResetPasswordProvider.hideConfPassword,
                toggleVisibility: () =>
                    mResetPasswordProvider.toggleConfPasswordVisibility(),
                controller: mResetPasswordProvider.confPassword,
                validator: (s) => TextFieldValidator.confirmPassword(
                    mResetPasswordProvider.password.text,
                    mResetPasswordProvider.confPassword.text),
                hasError: mResetPasswordProvider.confPasswordError,
                errorText: TextFieldValidator.confirmPassword(
                    mResetPasswordProvider.password.text,
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
                  mResetPasswordProvider.resetPassword(email);
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
