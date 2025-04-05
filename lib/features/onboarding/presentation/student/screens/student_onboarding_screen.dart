import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/config/app_routes.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/button.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/di/di.dart';
import 'package:resize/resize.dart';

import '../../../../../core/widgets/appbar.dart';

class StudentOnboardingScreen extends StatelessWidget {
  const StudentOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlueBg,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: '',
              showBackButton: Platform.isIOS ? true : false,
            ),
            Image.asset(
              AppImages.logo,
              height: 70.h,
            ),
            vHeight(44.h),
            Image.asset(
              AppImages.studentOnboardingIllustration,
              height: 257.h,
            ),
            const Spacer(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.w),
              padding: EdgeInsets.symmetric(horizontal: 3.vw, vertical: 3.vh),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: AppColors.white,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 13,
                      spreadRadius: 2,
                      color: AppColors.boxShadow,
                    ),
                  ]),
              child: Consumer(builder: (context, ref, _) {
                var provider = ref.watch(studentRegistrationProvider);
                return Column(
                  //TODO: Actual data not provided yet
                  children: [
                    SizedBox(
                      height: 20.vh,
                      child: PageView.builder(
                          onPageChanged: provider.updatePage,
                          itemCount: provider.totalPages,
                          // shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: 80.vw,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppText(
                                    AppStrings.onboardingTitle1,
                                    fontWeight: FontWeight.w700,
                                    textSize: 16.sp,
                                  ),
                                  vHeight(6.h),
                                  AppText(
                                    AppStrings.onboardingDesc1,
                                    textSize: 13.sp,
                                    lineHeight: 1.5,
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    vHeight(19.h),
                    SizedBox(
                      height: 10,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: provider.totalPages,
                        itemBuilder: (c, i) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 3.w),
                          height: i == provider.pageIndex ? 8.w : 5.w,
                          width: i == provider.pageIndex ? 8.w : 5.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: i == provider.pageIndex
                                ? AppColors.primary
                                : AppColors.indicatorInactiveBlue,
                          ),
                        ),
                      ),
                    ),
                    vHeight(55.h),
                    PrimaryAppButton(
                      title: AppStrings.getStarted,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.login);
                      },
                    )
                  ],
                );
              }),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
