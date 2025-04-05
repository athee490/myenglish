import 'dart:async';
import 'dart:io';

import 'package:fl_downloader/fl_downloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/appbar.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/features/course_deatils/presentation/tutor/providers/tutor_course_provider.dart';
import 'package:myenglish/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:resize/resize.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../../core/config/app_routes.dart';
import '../../../../../core/utils/helpers/app_helpers.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../../di/di.dart';
import '../../../../course_syllabus/data/models/student_selected_course_model.dart';
import '../../../../course_syllabus/presentation/provider/student_course_syllabus_provider.dart';

class StudentCourseDetailScreen extends ConsumerStatefulWidget {
  const StudentCourseDetailScreen({
    super.key,
  });

  @override
  ConsumerState<StudentCourseDetailScreen> createState() =>
      _StudentCourseDetailScreenState();
}

class _StudentCourseDetailScreenState
    extends ConsumerState<StudentCourseDetailScreen> {
  late StudentCourseSyllabusProvider mStudentCourseSyllabusProvider;
  late TutorCourseDetailsProvider mTutorCourseDetailsProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mStudentCourseSyllabusProvider = ref.read(studentCourseSyllabusProvider);
      mTutorCourseDetailsProvider = ref.read(tutorCourseDetailsProvider);
      mStudentCourseSyllabusProvider.generateThumbnail();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mStudentCourseSyllabusProvider = ref.watch(studentCourseSyllabusProvider);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const CustomAppBar(
              title: 'Course Detail',
              showBackButton: true,
            ),
            Expanded(
              child: mStudentCourseSyllabusProvider.isLoading
                  ? const LoaderWidget()
                  : Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 0),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Column(
                            children: [
                              videoView(),
                              vHeight(15.h),
                              courseDetails(),
                              vHeight(20.h),
                              pdfView(),
                            ],
                          ),
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget videoView() {
    mStudentCourseSyllabusProvider = ref.watch(studentCourseSyllabusProvider);
    return Consumer(
      builder: (context, ref, _) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * .25,
          width: double.infinity,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.videoScreen,
                  arguments:
                      mStudentCourseSyllabusProvider.singleCourseDetails);
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(18),
              ),
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .25,
                    width: double.infinity,
                    child: mStudentCourseSyllabusProvider
                            .thumbnailPath.isNotEmpty
                        ? Image.file(
                            File(mStudentCourseSyllabusProvider.thumbnailPath),
                            fit: BoxFit.fill,
                          )
                        : const LoaderWidget(),
                  ),
                  const Center(
                    child: Icon(
                      Icons.play_circle_outline_rounded,
                      size: 65,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget courseDetails() {
    mStudentCourseSyllabusProvider = ref.watch(studentCourseSyllabusProvider);
    mTutorCourseDetailsProvider = ref.watch(tutorCourseDetailsProvider);
    return Consumer(
      builder: (context, ref, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              '${mStudentCourseSyllabusProvider.singleCourseDetails?.title.toString()}',
              fontWeight: FontWeight.w700,
              textSize: 22.sp,
              textAlign: TextAlign.start,
              // lineHeight: 1,
            ),
            vHeight(18.h),
            AppText(
              '${mStudentCourseSyllabusProvider.singleCourseDetails?.keyword.toString()}',
              fontWeight: FontWeight.w400,
              textSize: 16.sp,
              textColor: AppColors.grey79,
              textAlign: TextAlign.start,
              // lineHeight: 1,
            ),
            vHeight(18.h),
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
            vHeight(8.h),
            Row(
              children: [
                AppText(
                  'Created by ',
                  fontWeight: FontWeight.w400,
                  textSize: 14.sp,
                  textColor: AppColors.grey79,
                  textAlign: TextAlign.start,
                ),
                AppText(
                  'Mina Farid',
                  fontWeight: FontWeight.w400,
                  textSize: 14.sp,
                  textColor: AppColors.primary,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            vHeight(8.h),
            Row(
              children: [
                Image.asset(
                  AppImages.errorCircle,
                  color: AppColors.black,
                ),
                width(5.w),
                AppText(
                  'From ${mStudentCourseSyllabusProvider.singleCourseDetails?.startDate.toString()} to ${mStudentCourseSyllabusProvider.singleCourseDetails?.endDate.toString()}',
                  fontWeight: FontWeight.w400,
                  textSize: 14.sp,
                  textColor: AppColors.primary,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            vHeight(8.h),
            AppText(
              '\$ ${mStudentCourseSyllabusProvider.singleCourseDetails?.price.toString()}',
              fontWeight: FontWeight.w900,
              textSize: 25.sp,
              textAlign: TextAlign.start,
            ),
            vHeight(2.h),
            AppText(
              '4 hours left at this price!',
              fontWeight: FontWeight.w900,
              textSize: 12.sp,
              textAlign: TextAlign.start,
              textColor: AppColors.red,
            ),
            vHeight(10.h),
            InkWell(
              onTap: () {
                // Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.payPalScreen);
                setState(() {
                  mTutorCourseDetailsProvider.courseId =
                      mStudentCourseSyllabusProvider.singleCourseDetails!.id
                          .toString();
                });
                mTutorCourseDetailsProvider.studentPayment();
              },
              child: Container(
                height: 55.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: AppColors.primary,
                ),
                child: Center(
                    child: AppText(
                  'Enroll Now',
                  fontWeight: FontWeight.w900,
                  textColor: AppColors.white,
                  textSize: 18.sp,
                )),
              ),
            ),
            vHeight(18.h),
            AppText(
              'Description',
              fontWeight: FontWeight.w900,
              textSize: 20.sp,
              textAlign: TextAlign.start,
            ),
            vHeight(8.h),
            AppText(
              '${mStudentCourseSyllabusProvider.singleCourseDetails?.longDescription.toString()}',
              fontWeight: FontWeight.w400,
              textSize: 16.sp,
              textColor: AppColors.grey79,
              textAlign: TextAlign.start,
              // lineHeight: 1,
            ),
          ],
        );
      },
    );
  }

  Widget pdfView() {
    mStudentCourseSyllabusProvider = ref.watch(studentCourseSyllabusProvider);
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .25,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.greyB1)),
          child: Image.asset(
            AppImages.pdf,
            // fit: BoxFit.fill,
          ),
        ),
        vHeight(20.h),
        Container(
          height: 55.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: AppColors.primary,
          ),
          child: Center(
            child: InkWell(
              onTap: () async {
                downloadPdf(mStudentCourseSyllabusProvider.singleCourseDetails!.syllabus.toString());
              },
              child: AppText(
                'Download',
                fontWeight: FontWeight.w900,
                textColor: AppColors.white,
                textSize: 18.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
