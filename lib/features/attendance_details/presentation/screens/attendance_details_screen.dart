import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/utils/helpers/app_helpers.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/appbar.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/core/widgets/image.dart';
import 'package:myenglish/core/widgets/loading_widget.dart';
import 'package:myenglish/di/di.dart';
import 'package:myenglish/features/attendance_details/data/models/home_attendance_model.dart';
import 'package:myenglish/features/profile/presentation/widgets/label.dart';
import 'package:resize/resize.dart';

class AttendanceDetailsScreen extends ConsumerStatefulWidget {
  final HomeAttendanceModel studentData;

  const AttendanceDetailsScreen({super.key, required this.studentData});

  @override
  ConsumerState<AttendanceDetailsScreen> createState() =>
      _AttendanceDetailsScreenState();
}

class _AttendanceDetailsScreenState
    extends ConsumerState<AttendanceDetailsScreen> {
  @override
  void initState() {
    super.initState();
    var mAttendanceProvider = ref.read(attendanceProvider);
    mAttendanceProvider.studentData = widget.studentData;
    mAttendanceProvider.fromDate =
        DateFormat('yyyy-MM-dd').format(widget.studentData.courseStartDate!);
    mAttendanceProvider.studentId = widget.studentData.studentId.toString();
    mAttendanceProvider.getAttendanceHistory();
    mAttendanceProvider.getStudentAttendanceData();
  }

  @override
  Widget build(BuildContext context) {
    var mAttendanceProvider = ref.watch(attendanceProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(title: AppStrings.attendanceDetails),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 24.h),
              child: filterDate(
                  mAttendanceProvider.fromDate, mAttendanceProvider.toDate),
            ),
            Expanded(
              child: mAttendanceProvider.isLoading
                  ? const LoaderWidget()
                  : SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.w, horizontal: 24.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              profileImageWidget(
                                  mAttendanceProvider.studentData.profileImage,
                                  mAttendanceProvider.studentData.name),
                              width(5.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppText(
                                    '${mAttendanceProvider.studentData.name}',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              mAttendanceProvider.studentData.courseId == 2
                                  ? yellowLabel()
                                  : purpleLabel(),
                              AppText(
                                '${timeToString(mAttendanceProvider.studentData.courseFromTime)} - ${timeToString(mAttendanceProvider.studentData.courseToTime)}',
                                fontWeight: FontWeight.w600,
                                textSize: 12.sp,
                              ),
                              AppText(
                                'Day ${differenceInDays(mAttendanceProvider.studentData.courseStartDate, DateTime.now()) + 1} of ${differenceInDays(mAttendanceProvider.studentData.courseStartDate, mAttendanceProvider.studentData.courseEndDate)}',
                                textColor: AppColors.grey79,
                                textSize: 12.sp,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              vHeight(10.h),
                              horizontalSeparatorWidget(),
                              vHeight(14.5.h),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    mAttendanceProvider.attendanceList.length,
                                itemBuilder: (c, i) {
                                  var dayData =
                                      mAttendanceProvider.attendanceList[i];
                                  return Row(
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: AppText(
                                            'Day ${differenceInDays(mAttendanceProvider.studentData.courseStartDate, dayData.fromDate) + 1}',
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
                                                  DateFormat('E').format(
                                                      dayData.fromDate!),
                                                  textSize: 12.sp,
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              flex: 2,
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: AppText(
                                                  DateFormat('dd/MM/yy').format(
                                                      dayData.fromDate!),
                                                  textSize: 12.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        flex: 3,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset((dayData
                                                              .studentAttendance ==
                                                          0 ||
                                                      dayData.tutorAttendance ==
                                                          0)
                                                  ? AppImages.errorCircle
                                                  : AppImages.tickCircle),
                                              AppText(
                                                '${dayData.duration}',
                                                textSize: 12.sp,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder: (c, i) => vHeight(10.h),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget filterDate(String fromDate, String toDate) {
    return Consumer(builder: (context, ref, _) {
      var provider = ref.watch(attendanceProvider);
      return InkWell(
        onTap: () async {
          var picked = await showDateRangePicker(
              initialDateRange: DateTimeRange(
                  start: DateTime.parse(provider.fromDate),
                  end: DateTime.parse(provider.toDate)),
              context: context,
              firstDate: DateTime.now().subtract(const Duration(days: 180)),
              lastDate: DateTime.now(),
              builder: (context, child) {
                return Center(
                  child: Theme(
                    data: ThemeData.dark().copyWith(
                      colorScheme: const ColorScheme.dark(
                        primary: AppColors.primary,
                        // onPrimary: AppColors.lightPurple,
                        surface: AppColors.primary,
                        onSurface: AppColors.white,
                      ),
                      dialogBackgroundColor: AppColors.white,
                    ),
                    child: child!,
                  ),
                );
              });
          if (picked != null) {
            provider.updateFilter(
                formatYYYYMMDD(picked.start), formatYYYYMMDD(picked.end));
          }
        },
        child: Container(
          padding: EdgeInsets.all(15.h),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.greyC3, width: 0.5)),
          child: Row(
            children: [
              Image.asset(
                AppImages.calendar,
                height: 24.h,
              ),
              width(10.w),
              const AppText(
                AppStrings.from,
                textColor: AppColors.greyC3,
              ),
              AppText(
                fromDate,
              ),
              const Spacer(),
              const AppText(
                AppStrings.to,
                textColor: AppColors.greyC3,
              ),
              AppText(
                toDate,
              ),
              const Spacer(),
            ],
          ),
        ),
      );
    });
  }
}
