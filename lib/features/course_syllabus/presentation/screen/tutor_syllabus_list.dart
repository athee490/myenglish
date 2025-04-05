import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/core/widgets/textfield.dart';
import 'package:resize/resize.dart';
import '../../../../core/config/app_routes.dart';
import '../../../../core/config/app_theme.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/appbar.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../di/di.dart';
import '../provider/student_course_syllabus_provider.dart';
import '../provider/tutor_course_syllabus_provider.dart';

class TutorCourseListScreen extends ConsumerStatefulWidget {
  const TutorCourseListScreen({super.key});

  @override
  ConsumerState<TutorCourseListScreen> createState() =>
      _TutorCourseListScreenState();
}

class _TutorCourseListScreenState extends ConsumerState<TutorCourseListScreen> {
  late TutorCourseSyllabusProvider mTutorCourseSyllabusProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var mCourseSyllabusProvider = ref.read(tutorCourseSyllabusProvider);
      mCourseSyllabusProvider.getTutorCourseDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mCourseSyllabusProvider = ref.watch(tutorCourseSyllabusProvider);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 0),
          child: Column(
            children: [
              const CustomAppBar(
                title: AppStrings.myClasses,
                showBackButton: false,
              ),
              mCourseSyllabusProvider.isLoading
                  ? LoaderWidget(
                      padding: EdgeInsets.only(top: 30.vh),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            courseSection(),
                          ],
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget courseSection() {
    return Consumer(builder: (context, ref, _) {
      var mCourseSyllabusProvider = ref.watch(tutorCourseSyllabusProvider);
      var mTutorCourseDetailsProvider = ref.watch(tutorCourseDetailsProvider);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          vHeight(10.h),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: mCourseSyllabusProvider.tutorCourseDetails.length,
            itemBuilder: (c, index) {
              var data = mCourseSyllabusProvider.tutorCourseDetails[index];
              return Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: AppTheme.boxShadow1),
                child: InkWell(
                  onTap: () async {
                    setState(() {
                      mTutorCourseDetailsProvider.courseId = data.id.toString();
                    });
                    mTutorCourseDetailsProvider.getSingleCourseDetails();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText(
                                        data.title.toString(),
                                        fontWeight: FontWeight.w700,
                                      ),
                                      AppText(
                                        data.keyword.toString(),
                                        fontWeight: FontWeight.w400,
                                        textSize: 11.sp,
                                        textColor: AppColors.grey79,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      vHeight(2.5.h),
                      horizontalSeparatorWidget(),
                      vHeight(10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.calendar_month,
                                size: 15,
                              ),
                              SizedBox(width: 2),
                              AppText(
                                'From ${data.startDate.toString()} to ${data.endDate.toString()}',
                                fontWeight: FontWeight.w400,
                                textSize: 12.sp,
                                textColor: AppColors.grey79,
                              ),
                            ],
                          ),
                        ],
                      ),
                      vHeight(5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 15,
                          ),
                          SizedBox(width: 2),
                          AppText(
                            '${data.startTime.toString()}  ${data.endTime.toString()}',
                            fontWeight: FontWeight.w400,
                            textSize: 12.sp,
                            textColor: AppColors.grey79,
                          ),
                        ],
                      ),
                      vHeight(5.h),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            AppText(
                              '3/5',
                              fontWeight: FontWeight.w400,
                              textSize: 14.sp,
                              textColor: AppColors.grey79,
                              textAlign: TextAlign.start,
                            ),
                            width(5.w),
                            for (int i = 0; i < 5; i++)
                              (i <= 2)
                                  ? Image.asset(
                                      'assets/images/rating_filled.png',
                                      height: 13,
                                    )
                                  : Image.asset(
                                      'assets/images/rating_unfilled.png',
                                      height: 13,
                                    ),
                          ],
                        ),
                      ),
                      vHeight(5.h),
                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                '${data.shortDescription.toString()}',
                                fontWeight: FontWeight.w800,
                                textSize: 13.sp,
                                textColor: AppColors.black,
                              ),
                              vHeight(0.5.h),
                              AppText(
                                '${data.longDescription.toString()}',
                                fontWeight: FontWeight.w400,
                                textSize: 10.sp,
                                textColor: AppColors.grey79,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (c, i) => vHeight(12.h),
          ),
        ],
      );
    });
  }
}
