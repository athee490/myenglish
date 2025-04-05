import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/config/app_theme.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/appbar.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/di/di.dart';
import 'package:resize/resize.dart';

class HelpAndSupportScreen extends ConsumerWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var mSupportProvider = ref.watch(supportProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(title: AppStrings.helpAndSupport),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //faq
                    blueTitleText(AppStrings.faq),
                    vHeight(12.h),
                    faqSection(),
                    vHeight(30.h),
                    //leave permission
                    // blueTitleText(AppStrings.leaveOrPermission),
                    // vHeight(6.h),
                    // leaveOrPermissionBody(),
                    // vHeight(30.h),
                    //admin contact info
                    adminContact(),
                    vHeight(30.h),
                    //other menu options
                    menuOption(AppStrings.termsAndCnditions),
                    horizontalSeparatorWidget(),
                    menuOption(AppStrings.privacyPolicy),
                    horizontalSeparatorWidget(),
                    menuOption(AppStrings.termsOfUse),
                    vHeight(30.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget faqSection() {
    return Consumer(builder: (context, ref, _) {
      var mSupportProvider = ref.watch(supportProvider);
      return Container(
        padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 18.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.greyDC),
        ),
        child: ListView.separated(
            shrinkWrap: true,
            itemCount: mSupportProvider.faq.length,
            separatorBuilder: (context, index) => horizontalSeparatorWidget(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => mSupportProvider.onTapFaq(index),
                child: Padding(
                  padding: EdgeInsets.only(top: 12.h, bottom: 16.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AppText(
                              mSupportProvider.faq[index].question,
                              textAlign: TextAlign.left,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          width(10.w),
                          AnimatedRotation(
                            duration: const Duration(milliseconds: 800),
                            turns: mSupportProvider.faq[index].isExpanded
                                ? 0.75
                                : 0.25,
                            child: Image.asset(
                              AppImages.frontArrow,
                              color: AppColors.greyB1,
                            ),
                          ),
                        ],
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 1000),
                        reverseDuration: const Duration(milliseconds: 1000),
                        switchInCurve: Curves.easeInOutBack,
                        switchOutCurve: Curves.easeInOutBack,
                        transitionBuilder: (child, animation) {
                          return SizeTransition(
                              sizeFactor: animation, child: child);
                        },
                        child: !mSupportProvider.faq[index].isExpanded
                            ? null
                            : Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: AppText(
                                  mSupportProvider.faq[index].answer,
                                  textSize: 12.sp,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              );
            }),
      );
    });
  }

  Widget leaveOrPermissionBody() {
    return Column(
      children: [
        'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. ',
        'Velit officia consequat duis enim velit mollit. ',
        'Consequat duis enim velit mollit. Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint.'
      ]
          .map(
            (e) => Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bulletin(),
                  Expanded(
                    child: AppText(
                      e,
                      textAlign: TextAlign.start,
                    ),
                  )
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget bulletin() {
    return Container(
      margin: EdgeInsets.fromLTRB(20.w, 10, 10, 0),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          shape: BoxShape.circle, border: Border.all(color: AppColors.primary)),
    );
  }

  Widget adminContact() {
    return Consumer(builder: (context, ref, _) {
      var mSupportProvider = ref.watch(supportProvider);
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.white,
          boxShadow: AppTheme.boxShadow1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              AppStrings.adminContact,
              textSize: 12.sp,
              textColor: AppColors.grey79,
            ),
            vHeight(10.h),
            InkWell(
              onTap: () => mSupportProvider.sendEmail(),
              child: Row(
                children: [
                  Image.asset(AppImages.sms),
                  width(12.w),
                  AppText(mSupportProvider.emailAddress,
                      fontWeight: FontWeight.w600)
                ],
              ),
            ),
            vHeight(15.h),
            InkWell(
              onTap: () => mSupportProvider.call(),
              child: Row(
                children: [
                  Image.asset(AppImages.call),
                  width(12.w),
                  AppText(mSupportProvider.contactNumber,
                      fontWeight: FontWeight.w600)
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget menuOption(String text, [void Function()? onTap]) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            blueTitleText(text),
            Image.asset(
              AppImages.frontArrow,
              color: AppColors.greyC3,
            ),
          ],
        ),
      ),
    );
  }

  AppText blueTitleText(String text) {
    return AppText(
      text,
      fontWeight: FontWeight.w700,
      textSize: 16.sp,
      textColor: AppColors.textBlueCA,
    );
  }
}
