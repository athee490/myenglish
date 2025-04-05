import 'package:flutter/material.dart';
import 'package:myenglish/core/config/app_routes.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_constants.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/widgets/toast.dart';
import 'package:myenglish/di/di.dart';
import 'package:myenglish/features/onboarding/domain/usecase/verify_otp_usecase.dart';
import 'package:myenglish/main.dart';

class OtpProvider extends ChangeNotifier {
  final VerifyOtpUseCase _verifyOtpUseCase;
  OtpProvider(this._verifyOtpUseCase);
  String otp = '';
  String actualOTP = '';

  verifyOtp(String email) async {
    if (otp.length != 6) {
      showToast('Enter 6 digit OTP', type: ToastType.error);
      return;
    }
    if (otp != actualOTP) {
      showToast('Invalid OTP', type: ToastType.error);
      return;
    }
    var data =
        await _verifyOtpUseCase.call(email, otp, appUserMap[getAppUser]!);
    if (data.isLeft()) {
      showToast(data.getLeft().error);
    } else {
      showToast('OTP verified', backgroundColor: AppColors.green);
      Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.resetPassword,
          arguments: {'email': email});
    }
  }
}
