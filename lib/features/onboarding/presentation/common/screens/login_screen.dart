import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/config/app_routes.dart';
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

import '../../../../../core/widgets/appbar.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var mLoginProvider = ref.watch(loginProvider);
    return AuthScaffold(
      child: Form(
        key: mLoginProvider.formKey,
        child: Column(
          children: [
            CustomAppBar(
              title: '',
              showBackButton: Platform.isIOS ? true : false,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    vHeight(66.h),
                    AppText(
                      AppStrings.loginToAccount,
                      fontWeight: FontWeight.w700,
                      textSize: 20.sp,
                    ),
                    vHeight(34.h),
                    PrimaryTextField(
                      controller: mLoginProvider.email,
                      label: AppStrings.emailId,
                      validator: TextFieldValidator.email,
                      type: TextInputType.emailAddress,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[0-9a-z_.@]"))
                      ],
                    ),
                    vHeight(18.h),
                    PasswordTextField(
                      label: AppStrings.password,
                      obscureText: mLoginProvider.hidePassword,
                      toggleVisibility: () => mLoginProvider.toggleVisibility(),
                      controller: mLoginProvider.password,
                      validator: (s) => TextFieldValidator.password(s),
                      hasError: mLoginProvider.passwordError,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      errorText: TextFieldValidator.password(
                          mLoginProvider.password.text),
                    ),
                    vHeight(34.h),
                    PrimaryAppButton(
                        title: AppStrings.signIn,
                        onTap: !mLoginProvider.buttonEnabled
                            ? null
                            : () => mLoginProvider.submit()),
                    AppTextButton(
                      text: AppStrings.iForgotPassword,
                      onTap: () => mLoginProvider.sendOtp(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const AppText(AppStrings.dontHaveAccount),
                        AppTextButton(
                          text: AppStrings.register,
                          onTap: () => getAppUser == AppUser.student
                              ? Navigator.pushNamed(
                                  context, AppRoutes.studentRegister)
                              : Navigator.pushNamed(
                                  context, AppRoutes.tutorRegister),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
