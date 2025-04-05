import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myenglish/core/config/app_routes.dart';
import 'package:myenglish/core/config/app_theme.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/utils/helpers/app_helpers.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/core/widgets/account_suspended_widget.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/button.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/core/widgets/image.dart';
import 'package:myenglish/core/widgets/loading_widget.dart';
import 'package:myenglish/core/widgets/toast.dart';
import 'package:myenglish/di/di.dart';
import 'package:myenglish/features/home/presentation/common/widgets/home_app_bar.dart';
import 'package:myenglish/features/profile/presentation/widgets/label.dart';
import 'package:resize/resize.dart';

import '../../../data/models/get_student_purchased_course_model.dart';

class StudentHomeScreen extends ConsumerStatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  ConsumerState<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends ConsumerState<StudentHomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(studentProfileProvider).getProfile();
      ref.read(studentHomeProvider).getStudentPurchasedCourse();
      init();
    });
    super.initState();
  }

  init() async {
    print('212121 Dashboard init');
    // await ref.read(studentHomeProvider).getDashboard();
    if (!ref.read(studentHomeProvider).accountSuspended) {
      // ref.read(studentProfileProvider).getProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var mHomeProvider = ref.watch(studentHomeProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vHeight(46.h),
              const HomeAppBar(),
              vHeight(52.h),
              AppText(
                DateFormat('E dd MMM').format(DateTime.now()).toUpperCase(),
                textSize: 11.sp,
                textColor: AppColors.greyB1,
              ),
              AppText(
                'Hi, ${Prefs().getString(Prefs.name)}',
                textSize: 25.sp,
                fontWeight: FontWeight.w700,
              ),
              vHeight(10.h),
              dashboardWidget(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget joinClassWidget(GetStudentPurchasedCourseDetails? data) {
    return Consumer(builder: (context, ref, _) {
      var mHomeProvider = ref.watch(studentHomeProvider);
      return Container(
        padding:
            EdgeInsets.only(top: 18.h, bottom: 20.h, left: 16.w, right: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.white,
          border: Border.all(color: AppColors.greyE9),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              '${data?.courseTitle.toString()}',
              fontWeight: FontWeight.w700,
              textSize: 15.sp,
              textAlign: TextAlign.start,
              // lineHeight: 1,
            ),
            vHeight(18.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      '${data?.startDate} - ${data?.endDate}',
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
                      '${data?.startTime} - ${data?.endTime}',
                      textSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
                // width(10.w),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: horizontalSeparatorWidget(),
            ),
            Row(
              children: [
                ImageFiltered(
                  imageFilter: mHomeProvider.paid && mHomeProvider.tutorAssigned
                      ? ImageFilter.blur(sigmaX: 0, sigmaY: 0)
                      : ImageFilter.blur(
                          sigmaX: 5.0, sigmaY: 4.0, tileMode: TileMode.decal),
                  child: Row(
                    children: [
                      Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                            color: AppColors.profileAvatarBg,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primary,
                            )),
                        child: Center(
                            child: profileImageWidget(
                                mHomeProvider.liveDetail?.tutorImage,
                                mHomeProvider.liveDetail?.tutorName)),
                      ),
                      width(10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            '${mHomeProvider.liveDetail?.tutorName}',
                            fontWeight: FontWeight.w700,
                          ),
                          if (mHomeProvider.liveDetail != null &&
                              mHomeProvider.liveDetail!.tutorActiveStatus ==
                                  0) ...{
                            AppText(
                              'Not Available',
                              textSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              textColor: Colors.red,
                            ),
                          },
                          AppText(
                            AppStrings.assignedTutor,
                            textSize: 12.sp,
                            textColor: AppColors.grey79,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                PrimaryAppButton(
                  title: AppStrings.joinLiveClass,
                  onTap: mHomeProvider.enableJoinClass
                      ? () async {
                          if (mHomeProvider.liveDetail?.callId != null) {
                            await mHomeProvider.checkRating();
                          } else {
                            showToast('Error joining Live class',
                                type: ToastType.error);
                          }
                        }
                      : null /*() {
                              mHomeProvider.showRatingDialog();
                            }*/
                  ,
                  textSize: 12.sp,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: horizontalSeparatorWidget(),
            ),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 44.h,
                      width: 44.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.lightBlueBg,
                      ),
                      child: Center(
                          child: Image.asset(
                        AppImages.calendarHalfFilled,
                      ))),
                  width(5.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppText(
                              '${data?.currentDay}',
                              fontWeight: FontWeight.w700,
                              textSize: 24.sp),
                          AppText(
                            '/${data?.courseDurationInDays}',
                            fontWeight: FontWeight.w700,
                            lineHeight: 2,
                          ),
                        ],
                      ),
                      AppText('Total no. of Days',
                          fontWeight: FontWeight.w600, textSize: 12.sp),
                      AppText(
                          checkNullOrEmptyString(
                                  data?.courseDurationInMonths.toString())
                              ? 'No Plan selected'
                              : '${data?.courseDurationInMonths} months Plan',
                          textSize: 11.sp,
                          textColor: AppColors.grey79),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget dashboardWidget(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        var mHomeProvider = ref.watch(studentHomeProvider);
        if (mHomeProvider.getPurchasedCourse.isEmpty) {
          return Center(
            child: AppText(
              'No purchased course in your profile',
              textSize: 16.sp,
              textColor: AppColors.grey79,
              fontWeight: FontWeight.w600,
            ),
          );
        } else {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: mHomeProvider.getPurchasedCourse.length,
            itemBuilder: (context, index) {
              var data = mHomeProvider.getPurchasedCourse[index];
              return Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: AppTheme.boxShadow1,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            mHomeProvider.dashboardData?.courseId == 0
                                ? yellowLabel(
                                    AppStrings.courseType.toUpperCase())
                                : mHomeProvider.dashboardData?.courseId == 1
                                    ? purpleLabel()
                                    : yellowLabel(),
                            const Spacer(),
                            InkWell(
                              onTap: () async {
                                mHomeProvider.selectedCourseId =
                                    data.enrollmentId.toString();
                                mHomeProvider.getPurchasedCourseDetails();
                              },
                              child: Row(
                                children: [
                                  AppText(
                                    AppStrings.planDetail,
                                    textSize: 12.sp,
                                  ),
                                  width(5.w),
                                  Image.asset(
                                    AppImages.frontArrow,
                                    color: AppColors.greyB1,
                                    height: 10.h,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        vHeight(18.h),
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
                                  '${data.startTime} - ${data.endTime}',
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
                  ),
                  vHeight(25.h),
                  joinClassWidget(data),
                  vHeight(10.h)
                ],
              );
            },
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => false;
}
