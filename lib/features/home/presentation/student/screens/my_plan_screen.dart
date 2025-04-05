import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myenglish/core/config/app_routes.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/utils/helpers/app_helpers.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/appbar.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/features/home/data/models/student_dashboard_model.dart';
import 'package:myenglish/features/profile/presentation/widgets/label.dart';
import 'package:resize/resize.dart';

import '../../../data/models/get_student_purchased_course_details_model.dart';

class MyPlanScreen extends StatelessWidget {
  final PurchasedCourseDetails data;

  const MyPlanScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(title: AppStrings.myPlan),
            vHeight(10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Column(
                children: [
                  Container(
                    height: 98.h,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 13,
                            spreadRadius: 2,
                            color: AppColors.boxShadow,
                          ),
                        ]),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: OverflowBox(
                            maxHeight: 160.w,
                            maxWidth: 160.w,
                            minHeight: 160.w,
                            minWidth: 160.w,
                            alignment: Alignment((-30.vw * 0.01), 0.1),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: AppColors.choosePlanBlue,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                // flex: 3,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: AppText(
                                    data.courseId.toString(),
                                    textSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        AppText(
                                          '${AppStrings.rupee} ${formatter.format(double.parse(data.price.toString()))}',
                                          textSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        const AppText(
                                          ' INR',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  vHeight(22.h),
                  Container(
                    padding: EdgeInsets.all(17.5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.white,
                      border: Border.all(color: AppColors.greyE9),
                    ),
                    child: Column(
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  data.courseId == 0
                                      ? yellowLabel(
                                          AppStrings.courseType.toUpperCase())
                                      : data.courseId == 1
                                          ? purpleLabel()
                                          : yellowLabel(),
                                  vHeight(2.5.h),
                                  AppText('${data.startDate}/day',
                                      fontWeight: FontWeight.w600,
                                      textSize: 14.sp),
                                ],
                              ),
                              const Spacer(),
                                Align(
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: () {
                                      // Navigator.pushNamed(
                                      //     context, AppRoutes.choosePlan,
                                      //     arguments: true);
                                    },
                                    child: FittedBox(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 17.5.h, horizontal: 15.w),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: AppColors.primary),
                                        ),
                                        child: Center(
                                            child: AppText(
                                          AppStrings.extendPlan,
                                          textColor: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                          textSize: 12.sp,
                                        )),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 17.h),
                          child: horizontalSeparatorWidget(),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(AppImages.calendarEmpty),
                            width(5.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  AppStrings.startAndExpiryDate,
                                  textSize: 12.sp,
                                  textColor: AppColors.grey79,
                                ),
                                AppText(
                                  '${data.startDate} - ${data.endDate}',
                                  textSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                            const Spacer(),
                            Image.asset(AppImages.clock),
                            width(5.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  AppStrings.classTiming,
                                  textSize: 12.sp,
                                  textColor: AppColors.grey79,
                                ),
                                AppText(
                                  '${data.startDate} - ${data.endDate}',
                                  textSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                            // width(10.w),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
