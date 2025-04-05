import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:myenglish/core/config/app_routes.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/utils/helpers/app_helpers.dart';
import 'package:myenglish/core/utils/helpers/textfield_validator.dart';
import 'package:myenglish/core/utils/services/fcm.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/core/widgets/account_suspended_widget.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/appbar.dart';
import 'package:myenglish/core/widgets/button.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/core/widgets/loading_widget.dart';
import 'package:myenglish/core/widgets/textfield.dart';
import 'package:myenglish/di/di.dart';
import 'package:myenglish/features/profile/presentation/dialogs/change_password_dialog.dart';
import 'package:myenglish/features/profile/presentation/dialogs/save_changes_dialog.dart';
import 'package:myenglish/features/profile/presentation/widgets/label.dart';
import 'package:resize/resize.dart';

class TutorProfileScreen extends ConsumerStatefulWidget {
  const TutorProfileScreen({super.key});

  @override
  ConsumerState<TutorProfileScreen> createState() => _TutorProfileScreenState();
}

class _TutorProfileScreenState extends ConsumerState<TutorProfileScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // ref.read(tutorProfileProvider).getDashboard();
      ref.read(tutorProfileProvider).getTutorProfile();
      ref.read(tutorProfileProvider).checkDate();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mTutorProfileProvider = ref.watch(tutorProfileProvider);

    willPop() {
      if (mTutorProfileProvider.areChangesMade()) {
        SaveChangesDialog(() => mTutorProfileProvider.editProfile()).show();
      } else {
        Navigator.pop(context);
      }
    }

    return WillPopScope(
      onWillPop: () async {
        if (mTutorProfileProvider.areChangesMade()) {
          SaveChangesDialog(() => mTutorProfileProvider.editProfile()).show();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                title: AppStrings.myProfile,
                willPop: willPop,
              ),
              Expanded(
                child: mTutorProfileProvider.isLoading
                    ? const LoaderWidget()
                    : mTutorProfileProvider.accountSuspended
                        ? AccountSuspendedWidget()
                        : Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24.w, vertical: 0),
                                  child: Form(
                                    key: mTutorProfileProvider.formKey,
                                    child: Column(
                                      children: [
                                        // vHeight(10),
                                        //card
                                        // profileCard(),
                                        // _subHeading(AppStrings.personalDetails),
                                        PrimaryTextField(
                                          label: AppStrings.fullName,
                                          maxLength: 20,
                                          controller:
                                              mTutorProfileProvider.name,
                                          validator: TextFieldValidator.name,
                                          type: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          autoValidateMode: AutovalidateMode
                                              .onUserInteraction,
                                        ),
                                        vHeight(18.h),
                                        // PrimaryTextField(
                                        //   label: AppStrings.mobileNo,
                                        //   controller:
                                        //       mTutorProfileProvider.mobileNo,
                                        //   readOnly: true,
                                        //   color: AppColors.greyFB,
                                        // ),
                                        AppMobileWithCountryTextField(
                                          readOnly: true,
                                          label: AppStrings.mobileNo,
                                          controller:
                                              mTutorProfileProvider.mobileNo,
                                          type: TextInputType.number,
                                          maxLength: 10,
                                          validator:
                                              TextFieldValidator.mobileNo,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp("[0-9]"))
                                          ],
                                          textInputAction: TextInputAction.next,
                                          prefixIcon: IntrinsicHeight(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IgnorePointer(
                                                  ignoring: true,
                                                  child: IntlPhoneField(
                                                    initialCountryCode:
                                                        mTutorProfileProvider
                                                            .countryCodeName,
                                                    showCountryCode: true,
                                                    showCountryFlag: false,
                                                    onCountryChanged: (c) {
                                                      print(
                                                          '212121 CountryCode frm UI: ${c.countryCode} , ${c.countryCode}');
                                                      mTutorProfileProvider
                                                              .countryCode =
                                                          c.countryCode;
                                                    },
                                                  ),
                                                ),
                                                verticalSeparatorWidget(
                                                    verticalMargin: 14)
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
                                          controller:
                                              mTutorProfileProvider.email,
                                          readOnly: true,
                                          color: AppColors.greyFB,
                                        ),
                                        // vHeight(18.h),
                                        // PrimaryTextField(
                                        //   label: AppStrings.dob,
                                        //   hint: 'DD/MM/YYYY',
                                        //   readOnly: true,
                                        //   color: AppColors.greyFB,
                                        //   controller: mTutorProfileProvider.dob,
                                        // ),
                                        // vHeight(18.h),
                                        // PrimaryTextField(
                                        //   label: AppStrings.pincode,
                                        //   controller:
                                        //       mTutorProfileProvider.pincode,
                                        //   type: TextInputType.number,
                                        //   validator: TextFieldValidator.pincode,
                                        //   autoValidateMode: AutovalidateMode
                                        //       .onUserInteraction,
                                        //   maxLength: 6,
                                        //   inputFormatters: [
                                        //     FilteringTextInputFormatter.deny(
                                        //         RegExp(r'\s')),
                                        //     FilteringTextInputFormatter
                                        //         .digitsOnly
                                        //   ],
                                        // ),
                                        // vHeight(18.h),
                                        // PrimaryTextField(
                                        //   label: AppStrings.occupation,
                                        //   controller:
                                        //       mTutorProfileProvider.occupation,
                                        //   maxLength: 30,
                                        //   validator:
                                        //       TextFieldValidator.fieldRequired,
                                        //   autoValidateMode: AutovalidateMode
                                        //       .onUserInteraction,
                                        //   textInputAction: TextInputAction.next,
                                        // ),
                                        // vHeight(18.h),
                                        vHeight(18.h),
                                        AppDropDownCountryField(
                                          label: 'Country',
                                          initialCountryCode:
                                              mTutorProfileProvider
                                                  .selectedCountry,
                                          showCountryFlag: false,
                                          showCountryName: true,
                                          showCountryCode: false,
                                          readOnly: true,
                                          onCountryChanged: (c) {
                                            print(
                                                '212121 CountryName from UI: ${c.countryCodeName} , ${c.countryCode}');
                                            mTutorProfileProvider
                                                    .selectedCountry =
                                                c.countryCodeName;
                                          },
                                        ),
                                        // vHeight(18.h),
                                        // AppDropDownTextField(
                                        //   label: AppStrings.teachAClass,
                                        //   items: mTutorProfileProvider
                                        //       .enrollToTeach,
                                        //   hint: 'Select',
                                        //   validator: (selectedItem) {
                                        //     if (selectedItem == null ||
                                        //         selectedItem.isEmpty) {
                                        //       return 'Please Select Teach a Class';
                                        //     }
                                        //     return null;
                                        //   },
                                        //   autoValidateMode: AutovalidateMode
                                        //       .onUserInteraction,
                                        //   onChanged: (selectedItem) {
                                        //     mTutorProfileProvider
                                        //         .updateSelectedEnrollToTeach(
                                        //             selectedItem);
                                        //     mTutorProfileProvider
                                        //         .validateDropDown(selectedItem);
                                        //   },
                                        // ),
                                        if (mTutorProfileProvider
                                                .selectedEnroll ==
                                            'K-12')
                                          //   Padding(
                                          //     padding: const EdgeInsets.only(
                                          //         top: 18.0),
                                          //     child: CustomDropdown(
                                          //       label: 'Grades',
                                          //       showLabel: true,
                                          //       items: mTutorProfileProvider
                                          //           .listOfGrades,
                                          //       showSuffixIcon: true,
                                          //       suffixIcon: const Icon(
                                          //         Icons
                                          //             .keyboard_arrow_down_rounded,
                                          //         color: Color(0xFF777474),
                                          //       ),
                                          //       onGradeChanged: (selectedGrade) {
                                          //         print(
                                          //             '212121 Selected Grade from UI : $selectedGrade Standard');
                                          //         // mCourseSyllabusProvider.selectedGrade = selectedGrade;
                                          //         Navigator.of(context).pop();
                                          //       },
                                          //     ),
                                          //   ),
                                          // vHeight(18.h),
                                          PrimaryTextField(
                                            label: AppStrings
                                                .degreeOfQualification,
                                            controller: mTutorProfileProvider
                                                .qualification,
                                            maxLength: 30,
                                            validator: TextFieldValidator
                                                .fieldRequired,
                                            autoValidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            textInputAction:
                                                TextInputAction.next,
                                          ),
                                        vHeight(18.h),
                                        PrimaryTextField(
                                          label: AppStrings.occupation,
                                          controller:
                                              mTutorProfileProvider.occupation,
                                          maxLength: 30,
                                          validator:
                                              TextFieldValidator.fieldRequired,
                                          autoValidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          textInputAction: TextInputAction.next,
                                        ),
                                        vHeight(18.h),
                                        PrimaryTextField(
                                          label: AppStrings.password,
                                          hint: '********',
                                          readOnly: true,
                                          suffixIcon: InkWell(
                                            onTap: () =>
                                                ChangePasswordDialog().show(),
                                            child: AppText(
                                              AppStrings.resetPassword,
                                              textDecoration:
                                                  TextDecoration.underline,
                                              textSize: 12.sp,
                                            ),
                                          ),
                                          // controller: mRegProvider.pincode,
                                        ),
                                        _subHeading(AppStrings.bankDetails),
                                        PrimaryTextField(
                                          label: AppStrings.bankName,
                                          maxLength: 20,
                                          controller:
                                          mTutorProfileProvider.accType,
                                          readOnly:
                                          mTutorProfileProvider.canEdit,
                                          validator:
                                          TextFieldValidator.fieldRequired,
                                          type: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          autoValidateMode: AutovalidateMode
                                              .onUserInteraction,
                                        ),
                                        vHeight(18.h),
                                        PrimaryTextField(
                                          label: AppStrings.accHolderName,
                                          controller:
                                          mTutorProfileProvider.accName,
                                          readOnly:
                                          mTutorProfileProvider.canEdit,
                                          validator: TextFieldValidator.name,
                                          type: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          autoValidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          maxLength: 20,
                                        ),
                                        vHeight(18.h),
                                        PrimaryTextField(
                                          label: AppStrings.ifscCode,
                                          controller:
                                              mTutorProfileProvider.ifsc,
                                          readOnly:
                                              mTutorProfileProvider.canEdit,
                                          validator:
                                              TextFieldValidator.fieldRequired,
                                          type: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          autoValidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          maxLength: 30,
                                        ),
                                        vHeight(18.h),
                                        PrimaryTextField(
                                          label: AppStrings.accNo,
                                          controller:
                                          mTutorProfileProvider.accNo,
                                          readOnly:
                                          mTutorProfileProvider.canEdit,
                                          type: TextInputType.number,
                                          validator: TextFieldValidator.accNo,
                                          maxLength: 20,
                                          autoValidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.deny(
                                                RegExp(r'\s')),
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          textInputAction: TextInputAction.next,
                                        ),
                                        vHeight(36.h),

                                        horizontalSeparatorWidget(),
                                        //logout
                                        InkWell(
                                          onTap: () async {
                                            await Prefs().clearPrefs();
                                            PushNotificationService
                                                .getFcmToken();
                                            if (context.mounted) {
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  AppRoutes.splash,
                                                  (route) => false);
                                            }
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 18.0.h),
                                            child: Row(
                                              children: [
                                                Image.asset(AppImages.logout),
                                                SizedBox(
                                                  width: 4.vw,
                                                ),
                                                AppText(
                                                  AppStrings.logout,
                                                  textSize: 16.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        vHeight(60.h),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    EdgeInsets.only(top: 10.h, bottom: 20.h),
                                color: AppColors.white,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    PrimaryAppButton(
                                      title: AppStrings.saveChanges,
                                      onTap: () =>
                                          mTutorProfileProvider.editProfile(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileCard() {
    return Consumer(builder: (context, ref, _) {
      var mProvider = ref.watch(tutorProfileProvider);
      return Container(
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 12.6.w),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 10,
                spreadRadius: 4,
                color: AppColors.boxShadow,
              )
            ]),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () => mProvider.pickImage(),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 45.h,
                        backgroundColor: AppColors.greyFB,
                        backgroundImage: mProvider.profilePicFile != null
                            ? Image.file(mProvider.profilePicFile!).image
                            : !checkNullOrEmptyString(
                                    mProvider.profilePictureUrl)
                                ? CachedNetworkImageProvider(
                                    mProvider.profilePictureUrl!)
                                : null,
                      ),
                      if (mProvider.profilePicFile == null &&
                          checkNullOrEmptyString(mProvider.profilePictureUrl))
                        AppText(
                          mProvider.name.text.substring(0, 1).toUpperCase(),
                          fontWeight: FontWeight.w900,
                          textSize: 40.sp,
                          textColor: AppColors.primary,
                        ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Image.asset(AppImages.camera)),
                    ],
                  ),
                ),
              ),
              width(15.w),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      toTitleCase(mProvider.name.text),
                      fontWeight: FontWeight.w700,
                      textSize: 21.sp,
                    ),
                    // if (mProvider.tutorData?.verified == 1)
                    //   AppText(
                    //     '${ref.read(tutorHomeProvider).dashboardData?.studentsAssigned.toString().padLeft(2, "0")} student assigned',
                    //     textSize: 12.sp,
                    //     textColor: AppColors.grey79,
                    //   ),
                    // if (mProvider.tutorData?.verified == 1)
                    //   mProvider.tutorData?.courseLevel == 'professional'
                    //       ? yellowLabel()
                    //       : purpleLabel()
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
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
