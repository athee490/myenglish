import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:resize/resize.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/helpers/textfield_validator.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/appbar.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/textfield.dart';
import '../../../../di/di.dart';

class EditTutorCourseSyllabus extends ConsumerStatefulWidget {
  const EditTutorCourseSyllabus({super.key});

  @override
  ConsumerState<EditTutorCourseSyllabus> createState() =>
      _EditTutorCourseSyllabus();
}

class _EditTutorCourseSyllabus extends ConsumerState<EditTutorCourseSyllabus> {
  @override
  void initState() {
    //  ref.read(tutorCourseDetailsProvider).getSingleCourseDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mTutorCourseDetailsProvider = ref.watch(tutorCourseDetailsProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              title: AppStrings.courseSyllabus,
              showBackButton: true,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 22.w, right: 22.w, bottom: 0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AppDropDownTextField(
                        label: AppStrings.teachAClass,
                        items: mTutorCourseDetailsProvider.enrollToTeach,
                        hint: 'Select',
                        value: mTutorCourseDetailsProvider.selectedEnroll.toString(),
                        validator: (selectedItem) {
                          if (selectedItem == null || selectedItem.isEmpty) {
                            return 'Please select Teach A Class';
                          }
                          return null;
                        },
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (selectedItem) {
                          mTutorCourseDetailsProvider
                              .updateSelectedEnrollToTeach(selectedItem);
                          mTutorCourseDetailsProvider
                              .validateDropDown(selectedItem);
                        },
                      ),
                      if (mTutorCourseDetailsProvider.selectedEnroll == 'K-12')
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: CustomDropdown(
                            label: 'Grades',
                            validator: (selectedGrade) {
                              if (selectedGrade == null || selectedGrade.isEmpty) {
                                return 'Please select a grade';
                              }
                              return null;
                            },
                            showLabel: true,
                            items: mTutorCourseDetailsProvider.listOfGrades,
                            showSuffixIcon: true,
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Color(0xFF777474),
                            ),
                            autoValidateMode: AutovalidateMode.onUserInteraction,
                            onGradeChanged: (selectedGrade) {
                              print(
                                  '212121 Selected Grade from UI : $selectedGrade Standard');
                              mTutorCourseDetailsProvider.updateSelectedGrade(selectedGrade);
                              mTutorCourseDetailsProvider.validateDropDown(selectedGrade);
                              // mCourseSyllabusProvider.selectedGrade = selectedGrade;
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      vHeight(18.h),
                      PrimaryTextField(
                        label: AppStrings.title,
                        controller: mTutorCourseDetailsProvider.courseTitle,
                        maxLength: 30,
                        validator: TextFieldValidator.fieldRequired,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                      ),
                      vHeight(18.h),
                      PrimaryTextField(
                        label: AppStrings.keyWords,
                        controller: mTutorCourseDetailsProvider.keyWords,
                        maxLength: 30,
                        validator: TextFieldValidator.fieldRequired,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                      ),
                      vHeight(14.h),
                      _uploadVideoResume(),
                      vHeight(14.h),
                      _dateRangePicker(),
                      vHeight(14.h),
                      AppDropDownTextField(
                        label: AppStrings.timeZone,
                        items: mTutorCourseDetailsProvider.timeZone,
                        hint: mTutorCourseDetailsProvider.selectedTimeZone
                            .toString(),
                        validator: (selectedItem) {
                          if (selectedItem == null || selectedItem.isEmpty) {
                            return 'Please select a time zone';
                          }
                          return null;
                        },
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (selectedItem) {},
                      ),
                      vHeight(14.h),
                      _timeZone(),
                      vHeight(14.h),
                      _price(),
                      vHeight(14.h),
                      _uploadSyllabusWidget(),
                      vHeight(14.h),
                      PrimaryTextField(
                        label: 'Short Description',
                        controller:
                            mTutorCourseDetailsProvider.shortDescription,
                        maxLines: 2,
                        maxLength: 50,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validator: (s) => s!.isEmpty ? 'Field required' : null,
                      ),
                      vHeight(14.h),
                      PrimaryTextField(
                        label: 'Long Description',
                        controller: mTutorCourseDetailsProvider.longDescription,
                        maxLines: 5,
                        maxLength: 150,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validator: (s) => s!.isEmpty ? 'Field required' : null,
                      ),

                      //submit
                      vHeight(56.h),
                      PrimaryAppButton(
                        title: AppStrings.saveAndContinue,
                        onTap: () =>mTutorCourseDetailsProvider.getSingleCourseDetails(),
                      ),
                      vHeight(40.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _uploadVideoResume() {
    return Consumer(
      builder: (context, ref, _) {
        var mTutorCourseDetailsProvider = ref.watch(tutorCourseDetailsProvider);
        return InkWell(
          onTap: () => mTutorCourseDetailsProvider.pickVideo(),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppColors.greyC3,
                ),
                color: AppColors.white),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const AppText(
                        AppStrings.video,
                        fontWeight: FontWeight.w700,
                      ),
                      width(4.w),
                      AppText(
                        '(minimum 1-3 mins)',
                        textSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  // vHeight(4.h),
                  Center(
                    child:mTutorCourseDetailsProvider.getVideoUrl.isNotEmpty?
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // SizedBox(
                        //   height: 120.h,
                        //   child:
                        //   AspectRatio(
                        //       aspectRatio: mTutorCourseDetailsProvider
                        //           .videoPlayerController
                        //           .value
                        //           .aspectRatio,
                        //       child: VideoPlayer(
                        //          VideoPlayerController.networkUrl(Uri.parse(mTutorCourseDetailsProvider.videoUrl.toString(),))
                        //           )),
                        // ),
                        AppText(
                          mTutorCourseDetailsProvider.getVideoUrl.toString(),
                          fontWeight: FontWeight.w600,
                          textSize: 12.sp,
                        )
                      ],
                    )
                        :
                    (mTutorCourseDetailsProvider.videoResumeFile !=
                                null &&
                            mTutorCourseDetailsProvider
                                .videoPlayerController.value.isInitialized)
                        ? mTutorCourseDetailsProvider.uploadingVideo
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                child: const SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: LoadingIndicator(
                                    indicatorType: Indicator.ballSpinFadeLoader,
                                    colors: [AppColors.primary],
                                  ),
                                ),
                              )
                            :
                    Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    height: 120.h,
                                    child:
                                    AspectRatio(
                                        aspectRatio: mTutorCourseDetailsProvider
                                            .videoPlayerController
                                            .value
                                            .aspectRatio,
                                        child: VideoPlayer(
                                            mTutorCourseDetailsProvider
                                                .videoPlayerController)),
                                  ),
                                  AppText(
                                    mTutorCourseDetailsProvider
                                        .videoResumeFile!.name,
                                    fontWeight: FontWeight.w600,
                                    textSize: 12.sp,
                                  )
                                ],
                              )
                        : Padding(
                            padding: EdgeInsets.symmetric(vertical: 35.h),
                            child: Column(
                              children: [
                                Image.asset(
                                  AppImages.uploadDocument,
                                  // height: 24.h,
                                ),
                                vHeight(6.h),
                                AppText(
                                  'Max 50MB',
                                  textSize: 12.sp,
                                  textColor: AppColors.greyC3,
                                )
                              ],
                            ),
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





  Widget _buildVideoContent(var provider) {
    if (provider.videoUrl.isNotEmpty) {
      return _buildVideoPlayerFromUrl(provider);
    }

    if (provider.videoResumeFile != null && provider.videoPlayerController != null && provider.videoPlayerController.value.isInitialized) {
      return provider.uploadingVideo ? _buildLoadingIndicator() : _buildVideoPlayerFromFile(provider);
    }

    return _buildUploadPlaceholder();
  }

  Widget _buildVideoPlayerFromUrl(var provider) {
    if (provider.videoPlayerController == null || !provider.videoPlayerController.value.isInitialized) {
      return _buildUploadPlaceholder();
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 120.h,
          child: AspectRatio(
            aspectRatio: provider.videoPlayerController.value.aspectRatio,
            child: VideoPlayer(
              VideoPlayerController.file(File.fromUri(Uri.parse(provider.videoUrl))),
            ),
          ),
        ),
        AppText(
          provider.videoResumeFile!.name,
          fontWeight: FontWeight.w600,
          textSize: 12.sp,
        ),
      ],
    );
  }

  Widget _buildVideoPlayerFromFile(var provider) {
    if (provider.videoPlayerController == null || !provider.videoPlayerController.value.isInitialized) {
      return _buildUploadPlaceholder();
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 120.h,
          child: AspectRatio(
            aspectRatio: provider.videoPlayerController.value.aspectRatio,
            child: VideoPlayer(provider.videoPlayerController),
          ),
        ),
        AppText(
          provider.videoResumeFile!.name,
          fontWeight: FontWeight.w600,
          textSize: 12.sp,
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: const SizedBox(
        height: 15,
        width: 15,
        child: LoadingIndicator(
          indicatorType: Indicator.ballSpinFadeLoader,
          colors: [AppColors.primary],
        ),
      ),
    );
  }

  Widget _buildUploadPlaceholder() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 35.h),
      child: Column(
        children: [
          Image.asset(
            AppImages.uploadDocument,
          ),
          vHeight(6.h),
          AppText(
            'Max 50MB',
            textSize: 12.sp,
            textColor: AppColors.greyC3,
          ),
        ],
      ),
    );
  }


  Widget _price() {
    var mTutorCourseDetailsProvider = ref.watch(tutorCourseDetailsProvider);
    String priceText = (mTutorCourseDetailsProvider.price.text);
    return PrimaryTextField(
      label: AppStrings.price,
      prefix: const Text('\$'),
      controller: TextEditingController(text: priceText),
      maxLength: 30,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _uploadSyllabusWidget() {
    return Consumer(
      builder: (context, ref, _) {
        var mTutorCourseDetailsProvider = ref.watch(tutorCourseDetailsProvider);
        return InkWell(
          onTap: () => mTutorCourseDetailsProvider.pickDocument(),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppColors.greyC3,
                ),
                color: AppColors.white),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    AppStrings.syllabus,
                    fontWeight: FontWeight.w700,
                  ),
                  // vHeight(4.h),
                  Center(
                    child: mTutorCourseDetailsProvider.documentUrl.isNotEmpty
                        ? AppText(
                            mTutorCourseDetailsProvider.documentUrl.toString().split('/').last)
                        : mTutorCourseDetailsProvider
                                    .documentProofPlatformFile !=
                                null
                            ? mTutorCourseDetailsProvider
                                        .documentProofPlatformFile!.extension ==
                                    'pdf'
                                ? AppText(mTutorCourseDetailsProvider
                                        .documentUrl.isNotEmpty
                                    ? mTutorCourseDetailsProvider.documentUrl
                                        .toString()
                                    : mTutorCourseDetailsProvider
                                        .documentProofPlatformFile!.name)
                                : Image.file(
                                    File(mTutorCourseDetailsProvider
                                        .documentProofPlatformFile!.path!),
                                    height: 120.h,
                                    // fit: BoxFit.scaleDown,
                                  )
                            : Padding(
                                padding: EdgeInsets.symmetric(vertical: 35.h),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      AppImages.uploadDocument,
                                      // height: 24.h,
                                    ),
                                    vHeight(6.h),
                                    AppText(
                                      'PDF',
                                      textSize: 12.sp,
                                      textColor: AppColors.greyC3,
                                    ),
                                  ],
                                ),
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

  Widget _dateRangePicker() {
    var mTutorCourseDetailsProvider = ref.watch(tutorCourseDetailsProvider);
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2025),
              );
              if (picked != null &&
                  picked != mTutorCourseDetailsProvider.fromDate) {
                setState(() {
                  mTutorCourseDetailsProvider.fromDate = picked;
                });
              }
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.greyC3),
                  borderRadius: BorderRadius.circular(18),
                  color: AppColors.white),
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    'From Date',
                    fontWeight: FontWeight.w700,
                  ),
                  vHeight(3.h),
                  AppText(
                    mTutorCourseDetailsProvider.fromDate == null
                        ? mTutorCourseDetailsProvider.forFromDate.toString()
                        : DateFormat.yMMMd()
                            .format(mTutorCourseDetailsProvider.fromDate!),
                    textSize: 14.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: InkWell(
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2025),
              );
              if (picked != null &&
                  picked != mTutorCourseDetailsProvider.toDate) {
                setState(() {
                  mTutorCourseDetailsProvider.toDate = picked;
                });
              }
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.greyC3),
                  borderRadius: BorderRadius.circular(18),
                  color: AppColors.white),
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    'To Date',
                    fontWeight: FontWeight.w700,
                  ),
                  vHeight(3.h),
                  AppText(
                    mTutorCourseDetailsProvider.toDate == null
                        ? mTutorCourseDetailsProvider.forToDate.toString()
                        : DateFormat.yMMMd()
                            .format(mTutorCourseDetailsProvider.toDate!),
                    textSize: 14.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _timeZone() {
    var mTutorCourseDetailsProvider = ref.watch(tutorCourseDetailsProvider);
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () async {
              TimeOfDay? selectedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (selectedTime != null) {
                DateTime now = DateTime.now();
                DateTime selectedDateTime = DateTime(
                  now.year,
                  now.month,
                  now.day,
                  selectedTime.hour,
                  selectedTime.minute,
                );
                setState(() {
                  mTutorCourseDetailsProvider.startTimeController.text =
                      selectedTime.format(context);
                  mTutorCourseDetailsProvider.startTime = selectedDateTime;
                });
              }
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.greyC3),
                borderRadius: BorderRadius.circular(18),
              ),
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    'Start Time',
                    fontWeight: FontWeight.w700,
                  ),
                  vHeight(3.h),
                  AppText(
                    mTutorCourseDetailsProvider
                            .startTimeController.text.isNotEmpty
                        ? mTutorCourseDetailsProvider.startTimeController.text
                            .toString()
                        : 'Select Start Time',
                    textSize: 14.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () async {
              TimeOfDay? selectedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (selectedTime != null) {
                DateTime now = DateTime.now();
                DateTime selectedDateTime = DateTime(
                  now.year,
                  now.month,
                  now.day,
                  selectedTime.hour,
                  selectedTime.minute,
                );
                setState(() {
                  mTutorCourseDetailsProvider.endTimeController.text =
                      selectedTime.format(context);
                  mTutorCourseDetailsProvider.endTime = selectedDateTime;
                });
              }
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.greyC3),
                borderRadius: BorderRadius.circular(18),
              ),
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    'End Time',
                    fontWeight: FontWeight.w700,
                  ),
                  vHeight(3.h),
                  AppText(
                    mTutorCourseDetailsProvider.endTimeController.text.isEmpty
                        ? 'Select Start Time'
                        : mTutorCourseDetailsProvider.endTimeController.text
                            .toString(),
                    textSize: 14.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
