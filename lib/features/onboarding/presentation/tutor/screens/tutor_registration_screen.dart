import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/utils/helpers/textfield_validator.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/button.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/core/widgets/textfield.dart';
import 'package:myenglish/di/di.dart';
import 'package:myenglish/features/onboarding/presentation/common/widgets/auth_scaffold.dart';
import 'package:resize/resize.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/widgets/appbar.dart';

class TutorRegistrationScreen extends ConsumerWidget {
  const TutorRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var mRegProvider = ref.watch(tutorRegistrationProvider);
    print(mRegProvider.selectedHow);
    return AuthScaffold(
      child: Column(
        children: [
          CustomAppBar(
            title: '',
            showBackButton: Platform.isIOS ? true : false,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                  left: 22.w,
                  right: 22.w,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Form(
                  key: mRegProvider.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(
                        AppStrings.welcome,
                        fontWeight: FontWeight.w700,
                        textSize: 20.sp,
                      ),
                      AppText(
                        AppStrings.pleaseEnterFollowingDetails,
                        textSize: 12.sp,
                      ),

                      //Personal details
                      _subHeading(AppStrings.personalDetails),
                      PrimaryTextField(
                        label: AppStrings.fullName,
                        maxLength: 20,
                        controller: mRegProvider.fullName,
                        validator: TextFieldValidator.name,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z_.@]"))
                        ],
                        type: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      vHeight(18.h),
                      AppMobileWithCountryTextField(
                        label: AppStrings.mobileNo,
                        controller: mRegProvider.mobileNo,
                        type: TextInputType.number,
                        maxLength: 10,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validator: TextFieldValidator.mobileNo,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                        ],
                        textInputAction: TextInputAction.next,
                        prefixIcon: IntrinsicHeight(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IntlPhoneField(
                                initialCountryCode:
                                    mRegProvider.countryCodeName,
                                showCountryCode: true,
                                showCountryFlag: false,
                                readOnly: true,
                                onCountryChanged: (c) {
                                  print('212121 CountryCode frm UI: ${c.countryCode} , ${c.countryCode}');
                                  mRegProvider.countryCode = c.countryCode;
                                },
                              ),
                              verticalSeparatorWidget(verticalMargin: 14)
                            ],
                          ),
                        ),
                      ),
                      vHeight(18.h),
                      PrimaryTextField(
                        label: AppStrings.emailAddress,
                        controller: mRegProvider.email,
                        type: TextInputType.emailAddress,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validator: TextFieldValidator.email,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp("[0-9a-z_.@]"))
                        ],
                        textInputAction: TextInputAction.next,
                      ),
                      vHeight(18.h),
                      AppDropDownCountryField(
                        label: 'Country',
                        initialCountryCode: mRegProvider.selectedCountry,
                        showCountryFlag: false,
                        showCountryName: true,
                        showCountryCode: false,
                        readOnly: true,
                        onCountryChanged: (c) {
                          print(
                              '212121 CountryName from UI: ${c.countryCodeName} , ${c.countryCode}');
                          mRegProvider.selectedCountry = c.countryCodeName;
                        },
                      ),
                      vHeight(18.h),
                      AppDropDownTextField(
                        label: AppStrings.teachAClass,
                        items: mRegProvider.enrollToTeach,
                        hint: 'Select',
                        validator: (selectedItem) {
                          if (selectedItem == null || selectedItem.isEmpty) {
                            return 'Please Select Teach a Class';
                          }
                          return null;
                        },
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (selectedItem) {
                          mRegProvider.updateSelectedEnrollToTeach(selectedItem);
                          mRegProvider.validateDropDown(selectedItem);
                        },
                      ),
                      if (mRegProvider.selectedEnroll == 'K-12')
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child:
                          CustomDropdown(
                            label: 'Grades',
                            validator: (selectedGrade) {
                              if (selectedGrade == null || selectedGrade.isEmpty) {
                                return 'Please select a grade';
                              }
                              return null;
                            },
                            showLabel: true,
                            items: mRegProvider.listOfGrades,
                            showSuffixIcon: true,
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Color(0xFF777474),
                            ),
                            autoValidateMode: AutovalidateMode.onUserInteraction,
                            onGradeChanged: (selectedGrade) {
                              mRegProvider.updateSelectedGrade(selectedGrade);
                              mRegProvider.validateDropDown(selectedGrade);
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      vHeight(18.h),
                      PrimaryTextField(
                        label: AppStrings.degreeOfQualification,
                        controller: mRegProvider.qualification,
                        maxLength: 30,
                        validator: TextFieldValidator.fieldRequired,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                      ),
                      vHeight(18.h),
                      PrimaryTextField(
                        label: AppStrings.occupation,
                        controller: mRegProvider.occupation,
                        maxLength: 30,
                        validator: TextFieldValidator.fieldRequired,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                      ),
                      vHeight(18.h),
                      _uploadVideoResume(),

                      //Document details
                      _subHeading(AppStrings.documentDetails),
                      AppDropDownTextField(
                        label: AppStrings.pleaseSelectTheDocument,
                        items: mRegProvider.documents,
                        hint: 'Select from the option',
                        validator: (selectedItem) {
                          if (selectedItem == null || selectedItem.isEmpty) {
                            return 'Field required';
                          }
                          return null;
                        },
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (selectedItem) {
                          mRegProvider.updateSelectedDocument(selectedItem);
                          mRegProvider.validateDropDown(selectedItem);
                        },
                      ),
                      vHeight(18.h),
                      _uploadWidget(),

                      //Bank details
                      _subHeading(AppStrings.bankDetails),
                      PrimaryTextField(
                        label: AppStrings.bankName,
                        maxLength:20,
                        controller: mRegProvider.bankName,
                        validator: TextFieldValidator.fieldRequired,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))],
                      ),
                      vHeight(18.h),
                      PrimaryTextField(
                        label: AppStrings.accHolderName,
                        maxLength:20,
                        controller: mRegProvider.accName,
                        validator: TextFieldValidator.name,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))],
                      ),
                      vHeight(18.h),
                      PrimaryTextField(
                        label: AppStrings.ifscCode,
                        maxLength:30,
                        controller: mRegProvider.ifsc,
                        validator: (s) =>
                            s!.length < 10 ? 'Enter valid IFSC code' : null,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp("[0-9a-zA-Z]")),
                        ],
                      ),
                      vHeight(18.h),
                      PrimaryTextField(
                        label: AppStrings.accNo,
                        maxLength:20,
                        controller: mRegProvider.accNo,
                        type: TextInputType.number,
                        validator: (s) => s!.length < 9 || s.length > 18
                            ? 'Enter valid Account Number'
                            : null,
                      ),
                      //submit
                      vHeight(56.h),
                      PrimaryAppButton(
                        title: AppStrings.saveAndContinue,
                        onTap: () => mRegProvider.saveAndContinue(),
                      ),
                      vHeight(40.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _uploadWidget() {
    return Consumer(
      builder: (context, ref, _) {
        var mProvider = ref.watch(tutorRegistrationProvider);
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
                    AppStrings.uploadDocument,
                    fontWeight: FontWeight.w700,
                  ),
                  vHeight(4.h),
                  Center(
                    child: mProvider.documentProofPlatformFile != null
                        ? mProvider.documentProofPlatformFile!.extension ==
                                'pdf'
                            ? AppText(mProvider.documentProofPlatformFile!.name)
                            : Image.file(
                                File(
                                    mProvider.documentProofPlatformFile!.path!),
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
                                  'PDF, JPG, PNG only',
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

  Widget _uploadVideoResume() {
    return Consumer(
      builder: (context, ref, _) {
        var mProvider = ref.watch(tutorRegistrationProvider);
        return InkWell(
          onTap: () => mProvider.pickVideo(),
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
                        AppStrings.attachVideoResume,
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
                  vHeight(4.h),
                  Center(
                    child: (mProvider.videoResumeFile != null &&
                            mProvider.videoPlayerController.value.isInitialized)
                        ? mProvider.uploadingVideo
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
                                        aspectRatio: mProvider
                                            .videoPlayerController
                                            .value
                                            .aspectRatio,
                                        child: VideoPlayer(
                                            mProvider.videoPlayerController)),
                                  ),
                                  AppText(
                                    mProvider.videoResumeFile!.name,
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

  Align _subHeading(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(top: 30.h, bottom: 12.h),
        child: AppText(
          title,
          textSize: 12.sp,
        ),
      ),
    );
  }
}
