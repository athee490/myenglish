import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:resize/resize.dart';

import '../config/app_routes.dart';
import '../constants/app_strings.dart';
import '../utils/services/fcm.dart';
import '../utils/services/prefs.dart';

class AccountSuspendedWidget extends StatelessWidget {
  bool isFromLogin;

  AccountSuspendedWidget({this.isFromLogin = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 100.vh,
          width: 100.vw,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Image.asset(AppImages.breakoutIllustration),
                    SizedBox(
                      height: 1.vh,
                    ),
                    AppText(
                      'Your account is on hold!',
                      textSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 1.vh,
                    ),
                    AppText(
                      'Please Contact +1 316-882-7967',
                      textSize: 16.sp,
                    ),
                    SizedBox(
                      height: 1.vh,
                    ),
                    if (!isFromLogin)
                      InkWell(
                        onTap: () async {
                          await Prefs().clearPrefs();
                          PushNotificationService.getFcmToken();
                          if (context.mounted) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, AppRoutes.splash, (route) => false);
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 18.0.h),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(AppImages.logout),
                              SizedBox(
                                width: 4.vw,
                              ),
                              AppText(
                                AppStrings.logout,
                                textSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Visibility(
                visible: isFromLogin,
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 20.w, top: 10.h),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              AppImages.backArrow,
                              height: 25.h,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            const AppText(
                              'Go Back',
                              fontWeight: FontWeight.w700,
                            )
                          ],
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
