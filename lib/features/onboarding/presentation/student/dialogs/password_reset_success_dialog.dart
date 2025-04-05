import 'package:flutter/material.dart';
import 'package:myenglish/core/config/app_routes.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/button.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/core/widgets/dialog.dart';
import 'package:myenglish/main.dart';
import 'package:resize/resize.dart';

class PasswordResetSuccessDialog extends CustomDialog {
  PasswordResetSuccessDialog();

  @override
  Widget getChild() {
    return Container(
      width: 80.vw,
      padding: EdgeInsets.all(35.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.lock,
            height: 116.h,
          ),
          AppText(
            AppStrings.passResetSuccess,
            fontWeight: FontWeight.w700,
            textSize: 16.sp,
          ),
          AppText(
            AppStrings.loginAgainToContinue,
            textSize: 12.sp,
            textAlign: TextAlign.center,
            lineHeight: 1.5,
          ),
          vHeight(30.sp),
          PrimaryAppButton(
            title: AppStrings.backToLogin,
            onTap: () => Navigator.pushNamedAndRemoveUntil(
                navigatorKey.currentContext!,
                AppRoutes.login,
                (route) => false),
          )
        ],
      ),
    );
  }

  @override
  void show() {
    super.showDialog(navigatorKey.currentContext!);
  }
}
