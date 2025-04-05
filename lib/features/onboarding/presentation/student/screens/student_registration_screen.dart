import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/utils/helpers/textfield_validator.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/button.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/core/widgets/textfield.dart';
import 'package:myenglish/di/di.dart';
import 'package:myenglish/features/onboarding/presentation/common/widgets/auth_scaffold.dart';
import 'package:resize/resize.dart';

import '../../../../../core/widgets/appbar.dart';

class StudentRegistrationScreen extends ConsumerWidget {
  const StudentRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var mRegProvider = ref.watch(studentRegistrationProvider);
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
                      controller: mRegProvider.fullName,
                      maxLength: 20,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z_.@]"))
                      ],
                      validator: TextFieldValidator.name,
                      type: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                    vHeight(18.h),
                    // PrimaryTextField(
                    //   label: AppStrings.mobileNo,
                    //   controller: mRegProvider.mobileNo,
                    //   type: TextInputType.number,
                    //   maxLength: 12,
                    //   validator: TextFieldValidator.mobileNo,
                    //   inputFormatters: <TextInputFormatter>[
                    //     FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                    //   ],
                    //   textInputAction: TextInputAction.next,
                    // ),
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
                              initialCountryCode: mRegProvider.countryCodeName,
                              showCountryCode: true,
                              showCountryFlag: false,
                              readOnly: true,
                              onCountryChanged: (c) {
                                print(
                                    '212121 CountryCode frm UI: ${c.countryCode} , ${c.countryCode}');
                                mRegProvider.countryCode = c.countryCode;
                              },
                            ),
                            verticalSeparatorWidget(verticalMargin: 14)
                            // Padding(
                            //     padding: const EdgeInsets.only(right: 0, left: 2),
                            //     child: verticalSeparatorWidget(verticalMargin: 14)),
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
                        FilteringTextInputFormatter.allow(RegExp("[0-9a-z_.@]"))
                      ],
                      textInputAction: TextInputAction.next,
                    ),
                    vHeight(18.h),
                    // PrimaryTextField(
                    //   label: AppStrings.dob,
                    //   hint: 'DD/MM/YYYY',
                    //   controller: mRegProvider.dob,
                    //   readOnly: true,
                    //   validator: TextFieldValidator.fieldRequired,
                    //   autoValidateMode: AutovalidateMode.onUserInteraction,
                    //   onTap: () {
                    //     showDatePicker(
                    //             context: context,
                    //             initialDate: DateTime.now()
                    //                 .subtract(const Duration(days: 365 * 12)),
                    //             firstDate: DateTime(1930),
                    //             lastDate: DateTime.now()
                    //                 .subtract(const Duration(days: 365 * 12)))
                    //         .then((value) {
                    //       if (value != null) {
                    //         mRegProvider.dob.text =
                    //             DateFormat('yyyy-MM-dd').format(value);
                    //         TextFieldValidator.fieldRequired(
                    //             DateFormat('yyyy-MM-dd').format(value));
                    //       }
                    //     });
                    //   },
                    // ),
                    // vHeight(18.h),
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
                    // PrimaryTextField(
                    //   label: AppStrings.pincode,
                    //   controller: mRegProvider.pincode,
                    //   type: TextInputType.number,
                    //   validator: TextFieldValidator.pincode,
                    //   autoValidateMode: AutovalidateMode.onUserInteraction,
                    //   maxLength: 6,
                    //   inputFormatters: [
                    //     FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    //     FilteringTextInputFormatter.digitsOnly
                    //   ],
                    //   textInputAction: TextInputAction.next,
                    // ),
                    //Educational Details
                    // _subHeading(AppStrings.selectEnrollment),
                    AppDropDownTextField(
                      label: AppStrings.selectEnrollment,
                      items: mRegProvider.enrollToTeach,
                      hint: 'Select from the option',
                      validator: (selectedItem) {
                        if (selectedItem == null || selectedItem.isEmpty) {
                          return 'Please select a grade';
                        }
                        return null;
                      },
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (selectedItem) {
                        mRegProvider.updateSelectedEnroll(selectedItem);
                        mRegProvider.validateDropDown(selectedItem);
                      },
                    ),
                    if (mRegProvider.selectedEnroll == 'K-12')
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
                    // vHeight(18.h),
                    // PrimaryTextField(
                    //   label: AppStrings.degreeOfQualification,
                    //   controller: mRegProvider.qualification,
                    //   maxLength: 30,
                    //   validator: TextFieldValidator.fieldRequired,
                    //   autoValidateMode: AutovalidateMode.onUserInteraction,
                    //   textInputAction: TextInputAction.next,
                    // ),
                    // vHeight(18.h),
                    // PrimaryTextField(
                    //   label: AppStrings.occupation,
                    //   controller: mRegProvider.occupation,
                    //   maxLength: 30,
                    //   validator: TextFieldValidator.fieldRequired,
                    //   autoValidateMode: AutovalidateMode.onUserInteraction,
                    //   textInputAction: TextInputAction.next,
                    // ),
                    //
                    // //Other required details
                    // _subHeading(AppStrings.otherReqDetails),
                    // AppDropDownTextField(
                    //   label: AppStrings.languageFluentIn,
                    //   items: mRegProvider.languages,
                    //   hint: 'Select from the option',
                    //   validator: (selectedItem) {
                    //     if (selectedItem == null || selectedItem.isEmpty) {
                    //       return 'Please select a language';
                    //     }
                    //     return null;
                    //   },
                    //   autoValidateMode: AutovalidateMode.onUserInteraction,
                    //   onChanged: (selectedItem) {
                    //     mRegProvider.updateSelectedLang(selectedItem);
                    //     mRegProvider.validateDropDown(selectedItem);
                    //   },
                    // ),
                    // if (mRegProvider.selectedLanguage == 'Other')
                    //   Padding(
                    //     padding: const EdgeInsets.only(top: 18.0),
                    //     child: PrimaryTextField(
                    //       label: 'Type your language',
                    //       controller: mRegProvider.otherLanguage,
                    //       maxLines: 1,
                    //       maxLength: 20,
                    //       autoValidateMode: AutovalidateMode.onUserInteraction,
                    //       validator: (s) =>
                    //           s!.isEmpty ? 'Field required' : null,
                    //     ),
                    //   ),
                    // vHeight(18.h),
                    // PrimaryTextField(
                    //   label: AppStrings.whatsYourGoal,
                    //   controller: mRegProvider.goal,
                    //   maxLines: 3,
                    //   maxLength: 100,
                    //   validator: TextFieldValidator.fieldRequired,
                    //   autoValidateMode: AutovalidateMode.onUserInteraction,
                    //   textInputAction: TextInputAction.next,
                    // ),
                    // vHeight(18.h),
                    // AppDropDownTextField(
                    //   label: AppStrings.availableTiming,
                    //   items: mRegProvider.timings.keys.toList(),
                    //   hint: 'Select from the option',
                    //   validator: (selectedItem) {
                    //     if (selectedItem == null || selectedItem.isEmpty) {
                    //       return 'Please select your availableTiming';
                    //     }
                    //     return null;
                    //   },
                    //   autoValidateMode: AutovalidateMode.onUserInteraction,
                    //   onChanged: (s) {
                    //     if (s != null) {
                    //       mRegProvider.availableTiming =
                    //           mRegProvider.timings[s];
                    //       mRegProvider
                    //           .validateDropDown(mRegProvider.timings[s]);
                    //       print(mRegProvider.availableTiming);
                    //     }
                    //   },
                    // ),
                    // vHeight(18.h),
                    // PrimaryTextField(
                    //   controller: mRegProvider.expectedDoj,
                    //   label: AppStrings.expectedDoj,
                    //   hint: 'DD/MM/YYYY',
                    //   readOnly: true,
                    //   validator: TextFieldValidator.fieldRequired,
                    //   autoValidateMode: AutovalidateMode.onUserInteraction,
                    //   onTap: () {
                    //     showDatePicker(
                    //             context: context,
                    //             initialDate:
                    //                 DateTime.now().add(const Duration(days: 3)),
                    //             firstDate:
                    //                 DateTime.now().add(const Duration(days: 3)),
                    //             lastDate: DateTime.now()
                    //                 .add(const Duration(days: 180)))
                    //         .then((value) {
                    //       if (value != null) {
                    //         mRegProvider.expectedDoj.text =
                    //             DateFormat('yyyy-MM-dd').format(value);
                    //         TextFieldValidator.fieldRequired(
                    //             DateFormat('yyyy-MM-dd').format(value));
                    //       }
                    //     });
                    //   },
                    // ),
                    // vHeight(18.h),
                    // AppDropDownTextField(
                    //   label: AppStrings.howDoYouKnowAboutRGVA,
                    //   items: mRegProvider.howDoYouKnowAboutMef,
                    //   hint: 'Select from the option',
                    //   validator: (selectedItem) {
                    //     if (selectedItem == null || selectedItem.isEmpty) {
                    //       return 'Field required';
                    //     }
                    //     return null;
                    //   },
                    //   autoValidateMode: AutovalidateMode.onUserInteraction,
                    //   onChanged: (selectedItem) {
                    //     mRegProvider.updateSelectedHow(selectedItem);
                    //   },
                    // ),
                    // if (mRegProvider.selectedHow == 'Other')
                    //   Padding(
                    //     padding: const EdgeInsets.only(top: 18.0),
                    //     child: PrimaryTextField(
                    //       label:
                    //           'Tell us where did you hear about Ramasser Group Virtual Academy',
                    //       controller: mRegProvider.reason,
                    //       maxLines: 3,
                    //       maxLength: 100,
                    //       autoValidateMode: AutovalidateMode.onUserInteraction,
                    //       validator: (s) =>
                    //           s!.isEmpty ? 'Field required' : null,
                    //     ),
                    //   ),

                    //submit
                    vHeight(56.h),
                    PrimaryAppButton(
                      title: AppStrings.saveAndContinue,
                      onTap: () => mRegProvider.setPassword(),
                    ),
                    vHeight(40.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
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
