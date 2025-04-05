import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myenglish/core/config/app_theme.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/button.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/core/widgets/image.dart';
import 'package:myenglish/core/widgets/loading_widget.dart';
import 'package:myenglish/core/widgets/will_pop.dart';
import 'package:myenglish/di/di.dart';
import 'package:myenglish/features/home/presentation/common/widgets/home_app_bar.dart';
import 'package:resize/resize.dart';

import '../../../../../core/widgets/account_suspended_widget.dart';

class TutorHomeScreen extends ConsumerStatefulWidget {
  const TutorHomeScreen({super.key});

  @override
  ConsumerState<TutorHomeScreen> createState() => _TutorHomeScreenState();
}

class _TutorHomeScreenState extends ConsumerState<TutorHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(tutorHomeProvider).getTutorTodayCourse();
      ref.read(tutorHomeProvider).getTutorStatistic();
      ref.watch(tutorProfileProvider).getTutorProfile();
      init();
    });
  }

  init() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(tutorHomeProvider).getStudentAttendanceDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    var mHomeProvider = ref.watch(tutorHomeProvider);
    var mTutorProfileProvider = ref.watch(tutorProfileProvider);
    return WillPopScope(
      onWillPop: willPop,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
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
                mHomeProvider.accountSuspended
                    ? Container(
                        alignment: Alignment.center,
                        height: 60.vh,
                        child: AccountSuspendedWidget(),
                      )
                    : mHomeProvider.loading
                        ? LoaderWidget(
                            padding: EdgeInsets.only(top: 30.vh),
                          )
                        : mHomeProvider.tutorStatisticsData.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    'Hi, ${Prefs().getString(Prefs.name)}',
                                    textSize: 25.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  dashboardWidget(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  AppText('Today\'s Classes'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  tutorTodayCourseDetails(),
                                  if(mHomeProvider.getStudentAttendanceData.length != 0)...{
                                    attendanceSection(),
                                  }
                                ],
                              )
                            : Center(
                                child: AppText(
                                  'No data available',
                                  textSize: 20.sp,
                                  textColor: AppColors.grey79,
                                ),
                              ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tutorTodayCourseDetails() {
    return Consumer(
      builder: (context, ref, _) {
        var mTutorHomeProvider = ref.watch(tutorHomeProvider);
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: mTutorHomeProvider.tutorTodayCourseDetails.length,
          itemBuilder: (context, index) {
            var data = mTutorHomeProvider.tutorTodayCourseDetails[index];
            return Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: AppTheme.boxShadow1,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText('${data.title}'),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: PrimaryAppButton(
                                title: AppStrings.joinLiveClass,
                                textSize: 12.sp,
                                onTap: () {
                                  mTutorHomeProvider.joinMeeting(room: data.id.toString());
                                }),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: horizontalSeparatorWidget(),
                      ),
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
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            );
          },
        );
      },
    );
  }

  Widget dashboardWidget() {
    return Consumer(
      builder: (context, ref, _) {
        var mTutorHomeProvider = ref.watch(tutorHomeProvider);
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: AppTheme.boxShadow1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Image.asset(
                          AppImages.studentsAssigned,
                          height: 44.h,
                        ),
                        width(2.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              '${mTutorHomeProvider.tutorStatisticsData.first.totalStudentsEnrolled.toString().padLeft(2, "0")}',
                              textSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            AppText(
                              AppStrings.studentsAssigned,
                              textSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Image.asset(
                          AppImages.classesConducted,
                          height: 44.h,
                        ),
                        width(2.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              '${mTutorHomeProvider.tutorStatisticsData.first.totalClassesConducted.toString().padLeft(2, "0")}',
                              textSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            AppText(
                              AppStrings.classedConducted,
                              textSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.vh,
              ),
              horizontalSeparatorWidget(),
              SizedBox(
                height: 1.vh,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppImages.amountEarned,
                    height: 44.h,
                  ),
                  width(2.w),
                  AppText(
                    '${mTutorHomeProvider.tutorStatisticsData.first.name}',
                    textSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  width(2.w),
                  AppText(
                    AppStrings.monthlyEarnings,
                    textSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget attendanceSection() {
    return Consumer(builder: (context, ref, _) {
      var mHomeProvider = ref.watch(tutorHomeProvider);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // vHeight(40.h),
          const AppText(
            'Attendance Log',
            fontWeight: FontWeight.w700,
          ),
          vHeight(12.h),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
             itemCount: mHomeProvider.getStudentAttendanceData.length,
            itemBuilder: (c, index) {
              var data = mHomeProvider.getStudentAttendanceData[index];
              return Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: AppTheme.boxShadow1,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            profileImageWidget(data.profileImage, data.name),
                            width(10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText('${data.name}',
                                    fontWeight: FontWeight.w700),
                                AppText(
                                  '${data.courseStartTime} - ${data.courseEndTime}',
                                  fontWeight: FontWeight.w400,
                                  textSize: 11.sp,
                                  textColor: AppColors.grey79,
                                )
                              ],
                            ),
                          ],
                        ),
                        vHeight(12.5.h),
                        horizontalSeparatorWidget(),
                        vHeight(10.h),
                        ListView.builder(
                          itemCount: data.attendance!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var dayData = data.attendance?[index];
                            return Row(
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: AppText(
                                      'Day ${dayData!.currentDay.toString()}',
                                      textSize: 12.sp,
                                      textColor: AppColors.grey79,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: AppText(
                                            '${dayData.dayName}',
                                            textSize: 12.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: AppText(
                                      '${dayData.todayDate}',
                                      textSize: 12.sp,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                            (dayData.studentAttendance == 0 ||
                                                    dayData.tutorAttendance ==
                                                        0)
                                                ? AppImages.errorCircle
                                                : AppImages.tickCircle),
                                        AppText(
                                          '${dayData.presentsMinutes}',
                                          textSize: 10.sp,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  vHeight(12.h)
                ],
              );
            },
            separatorBuilder: (c, i) => vHeight(12.h),
          ),
        ],
      );
    });
  }
}
