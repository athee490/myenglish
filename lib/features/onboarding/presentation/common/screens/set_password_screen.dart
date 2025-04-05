import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/utils/helpers/textfield_validator.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/button.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/core/widgets/textfield.dart';
import 'package:myenglish/di/di.dart';
import 'package:myenglish/features/onboarding/presentation/common/widgets/auth_scaffold.dart';
import 'package:resize/resize.dart';

class SetPasswordScreen extends ConsumerWidget {
  final bool reset;
  const SetPasswordScreen({super.key, this.reset = false});

  @override
  Widget build(BuildContext context, ref) {
    var mStudentRegProvider = ref.watch(studentRegistrationProvider);
    var mTutorRegProvider = ref.watch(tutorRegistrationProvider);
    var isStudent = getAppUser == AppUser.student;
    return WillPopScope(
      onWillPop: () async => false,
      child: AuthScaffold(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Form(
          key: isStudent
              ? mStudentRegProvider.passwordFormKey
              : mTutorRegProvider.passwordFormKey,
          child: Column(
            children: [
              vHeight(106.h),
              AppText(
                reset ? AppStrings.resetPassword : AppStrings.setPassword,
                fontWeight: FontWeight.w700,
                textSize: 20.sp,
              ),
              vHeight(34.h),
              PasswordTextField(
                label: AppStrings.password,
                obscureText: isStudent
                    ? mStudentRegProvider.hidePassword
                    : mTutorRegProvider.hidePassword,
                toggleVisibility: () => isStudent
                    ? mStudentRegProvider.toggleVisibility()
                    : mTutorRegProvider.toggleVisibility(),
                controller: isStudent
                    ? mStudentRegProvider.password
                    : mTutorRegProvider.password,
                validator: TextFieldValidator.newPassword,
                hasError: isStudent
                    ? mStudentRegProvider.passwordError
                    : mTutorRegProvider.passwordError,
                errorText: TextFieldValidator.newPassword(isStudent
                    ? mStudentRegProvider.password.text
                    : mTutorRegProvider.password.text),
              ),
              vHeight(18.h),
              PasswordTextField(
                label: AppStrings.confirmPassword,
                obscureText: isStudent
                    ? mStudentRegProvider.hideConfPassword
                    : mTutorRegProvider.hideConfPassword,
                toggleVisibility: () => isStudent
                    ? mStudentRegProvider.toggleConfPasswordVisibility()
                    : mTutorRegProvider.toggleConfPasswordVisibility(),
                controller: isStudent
                    ? mStudentRegProvider.confPassword
                    : mTutorRegProvider.confPassword,
                validator: (s) => TextFieldValidator.confirmPassword(
                    isStudent
                        ? mStudentRegProvider.password.text
                        : mTutorRegProvider.password.text,
                    isStudent
                        ? mStudentRegProvider.confPassword.text
                        : mTutorRegProvider.confPassword.text),
                hasError: isStudent
                    ? mStudentRegProvider.confPasswordError
                    : mTutorRegProvider.confPasswordError,
                errorText: TextFieldValidator.confirmPassword(
                    isStudent
                        ? mStudentRegProvider.password.text
                        : mTutorRegProvider.password.text,
                    isStudent
                        ? mStudentRegProvider.confPassword.text
                        : mTutorRegProvider.confPassword.text),
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
                title: reset
                    ? AppStrings.confirmPassword.toUpperCase()
                    : AppStrings.submit,
                onTap: () {
                  isStudent
                      ? mStudentRegProvider.submit()
                      : mTutorRegProvider.submit();
                },
                isLoading: isStudent
                    ? mStudentRegProvider.isLoading
                    : mTutorRegProvider.isLoading,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
