import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/appbar.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:resize/resize.dart';

import '../../../../../core/config/app_routes.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../../di/di.dart';
import '../providers/tutor_course_provider.dart';

class TutorCourseDetailScreen extends ConsumerStatefulWidget {
  const TutorCourseDetailScreen({super.key});

  @override
  ConsumerState<TutorCourseDetailScreen> createState() =>
      _TutorCourseDetailScreenState();
}

class _TutorCourseDetailScreenState
    extends ConsumerState<TutorCourseDetailScreen> {
  late TutorCourseDetailsProvider mTutorCourseDetailsProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(tutorCourseDetailsProvider);
      mTutorCourseDetailsProvider.generateThumbnail();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mTutorCourseDetailsProvider = ref.watch(tutorCourseDetailsProvider);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 9,
                  child: CustomAppBar(
                    title: 'Course Detail',
                    showBackButton: true,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.editTutorCourseSyllabus);
                    },
                    child: Image.asset(
                      'assets/images/edit.png',
                      height: 20.h,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0),
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
            ))
          ],
        ),
      ),
    );
  }

  Widget videoView() {
    mTutorCourseDetailsProvider = ref.watch(tutorCourseDetailsProvider);
    return Consumer(
      builder: (context, ref, _) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * .25,
          width: double.infinity,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.tutorVideoScreen,
                  arguments:
                      mTutorCourseDetailsProvider.tutorSingleCourseDetails);
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
                    child: mTutorCourseDetailsProvider.thumbnailPath.isNotEmpty
                        ? Image.file(
                            File(mTutorCourseDetailsProvider.thumbnailPath),
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
    var mTutorCourseDetailsProvider = ref.watch(tutorCourseDetailsProvider);
    return Consumer(
      builder: (context, ref, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              '${mTutorCourseDetailsProvider.tutorSingleCourseDetails?.title}',
              fontWeight: FontWeight.w700,
              textSize: 22.sp,
              textAlign: TextAlign.start,
            ),
            vHeight(18.h),
            AppText(
              '${mTutorCourseDetailsProvider.tutorSingleCourseDetails?.shortDescription}',
              fontWeight: FontWeight.w400,
              textSize: 16.sp,
              textColor: AppColors.grey79,
              textAlign: TextAlign.start,
            ),
            vHeight(18.h),
            Row(
              children: [
                AppText(
                  'From ',
                  fontWeight: FontWeight.w400,
                  textSize: 14.sp,
                  textColor: AppColors.grey79,
                  textAlign: TextAlign.start,
                ),
                AppText(
                  '${mTutorCourseDetailsProvider.tutorSingleCourseDetails?.startDate}',
                  fontWeight: FontWeight.w400,
                  textSize: 14.sp,
                  textColor: AppColors.primary,
                  textAlign: TextAlign.start,
                ),
                AppText(
                  'To ',
                  fontWeight: FontWeight.w400,
                  textSize: 14.sp,
                  textColor: AppColors.grey79,
                  textAlign: TextAlign.start,
                ),
                AppText(
                  '${mTutorCourseDetailsProvider.tutorSingleCourseDetails?.endDate}',
                  fontWeight: FontWeight.w400,
                  textSize: 14.sp,
                  textColor: AppColors.primary,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            vHeight(8.h),
            AppText(
              'Description',
              fontWeight: FontWeight.w900,
              textSize: 20.sp,
              textAlign: TextAlign.start,
            ),
            vHeight(8.h),
            AppText(
              '${mTutorCourseDetailsProvider.tutorSingleCourseDetails?.longDescription}',
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
    return Consumer(
      builder: (context, ref, _) {
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
          ],
        );
      },
    );
  }
}
