import 'package:flutter/material.dart';
import 'package:myenglish/core/config/app_routes.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:resize/resize.dart';

class UserSelectionScreen extends StatelessWidget {
  const UserSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.studentYellow,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0,
            child: Image.asset(
              AppImages.tutorBg,
              height: 55.vh,
              width: 100.vw,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
              top: 10.vh,
              child: AppText(
                'Please select your role',
                fontWeight: FontWeight.w700,
                textSize: 20.sp,
              )),
          Positioned(
            left: 7.5.vw,
            top: 25.vh,
            child: Row(
              children: [
                Image.asset(
                  AppImages.student,
                  height: 187.h,
                  width: 187.w,
                ),
                width(5.vw),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      AppStrings.imStudent,
                      fontWeight: FontWeight.w700,
                      textSize: 16.sp,
                    ),
                    vHeight(1.vh),
                    Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.tutorBlue),
                      child: IconButton(
                          onPressed: () {
                            Prefs()
                                .setString(Prefs.userType, AppStrings.student);
                            Navigator.pushNamed(
                                context, AppRoutes.studentOnboarding);
                          },
                          icon: Image.asset(AppImages.frontArrow)),
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
            right: 7.5.vw,
            bottom: 20.vh,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppText(
                      AppStrings.imTutor,
                      fontWeight: FontWeight.w700,
                      textSize: 16.sp,
                    ),
                    vHeight(1.vh),
                    Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.studentYellow),
                      child: IconButton(
                          onPressed: () {
                            Prefs().setString(Prefs.userType, AppStrings.tutor);
                            Navigator.pushNamed(
                                context, AppRoutes.tutorOnboarding);
                          },
                          icon: Image.asset(AppImages.backArrow)),
                    )
                  ],
                ),
                width(5.vw),
                Image.asset(
                  AppImages.tutor,
                  height: 187.h,
                  width: 187.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
