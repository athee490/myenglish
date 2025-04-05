import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/button.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/di/di.dart';
import 'package:myenglish/features/onboarding/presentation/common/widgets/auth_scaffold.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:resize/resize.dart';

import '../../../../../core/widgets/appbar.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String email;
  final String otp;

  const OtpScreen({
    super.key,
    required this.email,
    required this.otp,
  });

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  @override
  void initState() {
    super.initState();
    // ref.read(verifyOtpProvider).actualOTP = widget.otp;
  }

  @override
  Widget build(BuildContext context) {
    var mOtpProvider = ref.watch(verifyOtpProvider);
    mOtpProvider.actualOTP = widget.otp;
    return AuthScaffold(
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
                    AppStrings.otpVerification,
                    fontWeight: FontWeight.w700,
                    textSize: 20.sp,
                  ),
                  vHeight(5.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: AppText(
                      AppStrings.otpVerificationDesc,
                      textSize: 12.sp,
                    ),
                  ),
                  vHeight(35.h),
                  //otp field
                  OTPTextField(
                    key: const ObjectKey('otpField'),
                    textFieldAlignment: MainAxisAlignment.center,
                    length: 6,
                    otpFieldStyle: OtpFieldStyle(borderColor: AppColors.grey79),
                    fieldStyle: FieldStyle.box,
                    spaceBetween: 10.w,
                    fieldWidth: 45.w,
                    width: 90.vw,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 4),
                    outlineBorderRadius: 18.h,
                    onChanged: (s) {
                      mOtpProvider.otp = s;
                    },
                  ),
                  vHeight(90.h),
                  // AppText(
                  //   '0:30s',
                  //   textSize: 12.sp,
                  // ),
                  // vHeight(18.h),
                  PrimaryAppButton(
                    title: AppStrings.confirmOtp,
                    onTap: () => mOtpProvider.verifyOtp(widget.email),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
