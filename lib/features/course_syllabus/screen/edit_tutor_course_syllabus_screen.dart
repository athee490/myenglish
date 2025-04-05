import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:resize/resize.dart';
import 'package:video_player/video_player.dart';

import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/helpers/textfield_validator.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../core/widgets/textfield.dart';
import '../../../di/di.dart';

class EditTutorCourseSyllabus extends ConsumerStatefulWidget {
  const EditTutorCourseSyllabus({super.key});
  @override
  ConsumerState<EditTutorCourseSyllabus> createState() => _EditTutorCourseSyllabus();
}

class _EditTutorCourseSyllabus extends ConsumerState<EditTutorCourseSyllabus> {
  @override
  Widget build(BuildContext context) {
    var mCourseSyllabusProvider = ref.watch(tutorCourseSyllabusProvider);

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
                        items: mCourseSyllabusProvider.enrollToTeach,
                        hint: 'Select',
                        validator: (selectedItem) {
                          if (selectedItem == null || selectedItem.isEmpty) {
                            return 'Please select Teach A Class';
                          }
                          return null;
                        },
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (selectedItem) {
                          mCourseSyllabusProvider
                              .updateSelectedEnrollToTeach(selectedItem);
                          mCourseSyllabusProvider
                              .validateDropDown(selectedItem);
                        },
                      ),
                      if (mCourseSyllabusProvider.selectedEnroll == 'KG-12')
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: CustomDropdown(
                            label: 'Grades',
                            showLabel: true,
                            items: mCourseSyllabusProvider.listOfGrades,
                            showSuffixIcon: true,
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Color(0xFF777474),
                            ),
                            onGradeChanged: (selectedGrade) {
                              print(
                                  '212121 Selected Grade from UI : $selectedGrade Standard');
                              // mCourseSyllabusProvider.selectedGrade = selectedGrade;
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      // AppDropDownTextField(
                      //   label: AppStrings.grade,
                      //   items: mCourseSyllabusProvider.grades,
                      //   hint: 'Select from the option',
                      //   validator: (selectedItem) {
                      //     if (selectedItem == null || selectedItem.isEmpty) {
                      //       return 'Please select a grade';
                      //     }
                      //     return null;
                      //   },
                      //   autoValidateMode: AutovalidateMode.onUserInteraction,
                      //   onChanged: (selectedItem) {},
                      // ),
                      vHeight(18.h),
                      PrimaryTextField(
                        label: AppStrings.title,
                        controller: mCourseSyllabusProvider.courseTitle,
                        maxLength: 30,
                        validator: TextFieldValidator.fieldRequired,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                      ),
                      vHeight(18.h),
                      PrimaryTextField(
                        label: AppStrings.keyWords,
                        controller: mCourseSyllabusProvider.keyWords,
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
                        items: mCourseSyllabusProvider.timeZone,
                        hint: 'Select',
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
                        controller: mCourseSyllabusProvider.shortDescription,
                        maxLines: 2,
                        maxLength: 50,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validator: (s) => s!.isEmpty ? 'Field required' : null,
                      ),
                      vHeight(14.h),
                      PrimaryTextField(
                        label: 'Long Description',
                        controller: mCourseSyllabusProvider.longDescription,
                        maxLines: 5,
                        maxLength: 150,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validator: (s) => s!.isEmpty ? 'Field required' : null,
                      ),

                      //submit
                      vHeight(56.h),
                      PrimaryAppButton(
                        title: AppStrings.saveAndContinue,
                        onTap: () {},
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
        var mCourseSyllabusProvider = ref.watch(tutorCourseSyllabusProvider);
        return InkWell(
          onTap: () => mCourseSyllabusProvider.pickVideo(),
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
                    child: (mCourseSyllabusProvider.videoResumeFile != null &&
                        mCourseSyllabusProvider
                            .videoPlayerController.value.isInitialized)
                        ? mCourseSyllabusProvider.uploadingVideo
                        ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: const SizedBox(
                          height: 15,
                          width: 15,
                          child: LoadingIndicator(
                            indicatorType:
                            Indicator.ballSpinFadeLoader,
                            colors: [AppColors.primary],
                          )),
                    )
                        : Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 120.h,
                          child: AspectRatio(
                              aspectRatio: mCourseSyllabusProvider
                                  .videoPlayerController
                                  .value
                                  .aspectRatio,
                              child: VideoPlayer(
                                  mCourseSyllabusProvider
                                      .videoPlayerController)),
                        ),
                        AppText(
                          mCourseSyllabusProvider
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

  Widget _price() {
    var mCourseSyllabusProvider = ref.watch(tutorCourseSyllabusProvider);
    String priceText = (mCourseSyllabusProvider.price.text);
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
        var mCourseSyllabusProvider = ref.watch(tutorCourseSyllabusProvider);
        return InkWell(
          onTap: () => ref.read(tutorRegistrationProvider).pickDocument(),
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
                    child: mCourseSyllabusProvider.documentProofPlatformFile !=
                        null
                        ? mCourseSyllabusProvider
                        .documentProofPlatformFile!.extension ==
                        'pdf'
                        ? AppText(mCourseSyllabusProvider
                        .documentProofPlatformFile!.name)
                        : Image.file(
                      File(mCourseSyllabusProvider
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

  Widget _dateRangePicker() {
    var mCourseSyllabusProvider = ref.watch(tutorCourseSyllabusProvider);
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
                  picked != mCourseSyllabusProvider.fromDate) {
                setState(() {
                  mCourseSyllabusProvider.fromDate = picked;
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
                    mCourseSyllabusProvider.fromDate == null
                        ? 'Select From Date'
                        : DateFormat.yMMMd()
                        .format(mCourseSyllabusProvider.fromDate!),
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
              if (picked != null && picked != mCourseSyllabusProvider.toDate) {
                setState(() {
                  mCourseSyllabusProvider.toDate = picked;
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
                    mCourseSyllabusProvider.toDate == null
                        ? 'Select To Date'
                        : DateFormat.yMMMd()
                        .format(mCourseSyllabusProvider.toDate!),
                    textSize: 14.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
            ),
          ),
        ),
        // Expanded(
        //   child: InkWell(
        //     onTap: () async {
        //       final DateTime? picked = await showDatePicker(
        //         context: context,
        //         initialDate: DateTime.now(),
        //         firstDate: DateTime(2020),
        //         lastDate: DateTime(2025),
        //       );
        //       if (picked != null && picked != mCourseSyllabusProvider.toDate) {
        //         setState(() {
        //           mCourseSyllabusProvider.toDate = picked;
        //         });
        //       }
        //     },
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text('To Date'),
        //         vHeight(10.h),
        //         Container(
        //           width: double.infinity,
        //           decoration: BoxDecoration(
        //             border: Border.all(color: AppColors.greyC3),
        //             borderRadius: BorderRadius.circular(10),
        //           ),
        //           padding: EdgeInsets.all(10.0),
        //           child: Text(
        //             mCourseSyllabusProvider.toDate == null
        //                 ? 'Select To Date'
        //                 : DateFormat.yMMMd()
        //                     .format(mCourseSyllabusProvider.toDate!),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _timeZone() {
    var mCourseSyllabusProvider = ref.watch(tutorCourseSyllabusProvider);
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
                  mCourseSyllabusProvider.startTimeController.text =
                      selectedTime.format(context);
                  mCourseSyllabusProvider.startTime = selectedDateTime;
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
                    mCourseSyllabusProvider.startTimeController.text.isEmpty
                        ? 'Select Start Time'
                        : mCourseSyllabusProvider.startTimeController.text,
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
                  mCourseSyllabusProvider.endTimeController.text =
                      selectedTime.format(context);
                  mCourseSyllabusProvider.endTime = selectedDateTime;
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
                    mCourseSyllabusProvider.endTimeController.text.isEmpty
                        ? 'Select Start Time'
                        : mCourseSyllabusProvider.endTimeController.text,
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
