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
import 'package:myenglish/core/widgets/textfield.dart';
import 'package:myenglish/di/di.dart';
import 'package:myenglish/features/profile/presentation/dialogs/change_password_dialog.dart';
import 'package:myenglish/features/profile/presentation/dialogs/save_changes_dialog.dart';
import 'package:myenglish/features/profile/presentation/widgets/label.dart';
import 'package:resize/resize.dart';

import '../../../../core/widgets/loading_widget.dart';

class StudentProfileScreen extends ConsumerStatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  ConsumerState<StudentProfileScreen> createState() =>
      _StudentProfileScreenState();
}

class _StudentProfileScreenState extends ConsumerState<StudentProfileScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // ref.read(studentProfileProvider).getDashboard();
      ref.read(studentProfileProvider).getProfile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mStudentProfileProvider = ref.watch(studentProfileProvider);

    willPop() {
      if (mStudentProfileProvider.areChangesMade()) {
        SaveChangesDialog(() => mStudentProfileProvider.editProfile()).show();
      } else {
        Navigator.pop(context);
      }
    }

    return WillPopScope(
      onWillPop: () async {
        if (mStudentProfileProvider.areChangesMade()) {
          SaveChangesDialog(() => mStudentProfileProvider.editProfile()).show();
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
                child: mStudentProfileProvider.accountSuspended
                    ? AccountSuspendedWidget()
                    : mStudentProfileProvider.isLoading
                        ? const LoaderWidget()
                        : Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24.w, vertical: 0),
                                  child: Form(
                                    key: mStudentProfileProvider.formKey,
                                    child: Column(
                                      children: [
                                        //card
                                        if (ref
                                                .read(studentHomeProvider)
                                                .dashboardData !=
                                            null)
                                          profileCard(),
                                        vHeight(25.h),
                                        PrimaryTextField(
                                          label: AppStrings.fullName,
                                          controller:
                                              mStudentProfileProvider.name,
                                          maxLength: 20,
                                          autoValidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: TextFieldValidator.name,
                                          type: TextInputType.name,
                                          textInputAction: TextInputAction.next,
                                        ),
                                        vHeight(18.h),
                                        AppMobileWithCountryTextField(
                                          readOnly: true,
                                          label: AppStrings.mobileNo,
                                          controller:
                                              mStudentProfileProvider.mobileNo,
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
                                                        mStudentProfileProvider
                                                            .countryCodeName,
                                                    showCountryCode: true,
                                                    showCountryFlag: false,
                                                    onCountryChanged: (c) {
                                                      print(
                                                          '212121 CountryCode frm UI: ${c.countryCode} , ${c.countryCode}');
                                                      mStudentProfileProvider
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
                                              mStudentProfileProvider.email,
                                          // type: TextInputType.emailAddress,
                                          // validator: TextFieldValidator.email,
                                          // inputFormatters: <TextInputFormatter>[
                                          //   FilteringTextInputFormatter.allow(
                                          //       RegExp("[0-9a-z_.@]"))
                                          // ],
                                          // textInputAction: TextInputAction.next,
                                          readOnly: true,
                                          color: AppColors.greyFB,
                                        ),
                                        vHeight(18.h),
                                        AppDropDownCountryField(
                                          label: 'Country',
                                          initialCountryCode:
                                              mStudentProfileProvider
                                                          .selectedCountry ==
                                                      ''
                                                  ? "Please Select a Country"
                                                  : mStudentProfileProvider
                                                      .selectedCountry
                                                      .toString(),
                                          showCountryFlag: false,
                                          showCountryName: true,
                                          showCountryCode: false,
                                          readOnly: true,
                                          onCountryChanged: (c) {
                                            print(
                                                '212121 CountryName from UI: ${c.countryCodeName} , ${c.countryCode}');
                                            mStudentProfileProvider
                                                    .selectedCountry =
                                                c.countryCodeName;
                                            mStudentProfileProvider
                                                    .selectedCountryCode =
                                                c.countryCode;
                                          },
                                        ),
                                        _subHeading(
                                            AppStrings.educationalDetails),
                                        AppDropDownTextField(
                                          label: AppStrings.selectEnrollment,
                                          items: mStudentProfileProvider
                                              .enrollToTeach,
                                          hint: mStudentProfileProvider
                                                      .selectedEnroll ==
                                                  ''
                                              ? 'Select from the option'
                                              : mStudentProfileProvider
                                                  .selectedEnroll
                                                  .toString(),
                                          validator: (selectedItem) {
                                            if (selectedItem == null ||
                                                selectedItem.isEmpty) {
                                              return 'Please select a grade';
                                            }
                                            return null;
                                          },
                                          autoValidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          onChanged: (selectedItem) {
                                            mStudentProfileProvider
                                                .updateSelectedEnroll(
                                                    selectedItem!);
                                            mStudentProfileProvider
                                                .validateDropDown(selectedItem);
                                          },
                                        ),
                                        if (mStudentProfileProvider
                                                .selectedEnroll ==
                                            'K-12')
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 18.0),
                                            child: CustomDropdown(
                                              label: 'Grades',
                                              selectedGrade:
                                                  mStudentProfileProvider
                                                      .selectedGrade
                                                      .toString(),
                                              validator: (selectedGrade) {
                                                if (selectedGrade == null ||
                                                    selectedGrade.isEmpty) {
                                                  return 'Please select a grade';
                                                }
                                                return null;
                                              },
                                              showLabel: true,
                                              items: mStudentProfileProvider
                                                  .listOfGrades,
                                              showSuffixIcon: true,
                                              suffixIcon: const Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                color: Color(0xFF777474),
                                              ),
                                              onGradeChanged: (selectedGrade) {
                                                print(
                                                    '212121 Selected Grade from UI : $selectedGrade Standard');
                                                mStudentProfileProvider
                                                    .updateSelectedGrade(
                                                        selectedGrade);
                                                mStudentProfileProvider
                                                    .validateDropDown(
                                                        selectedGrade);
                                                Navigator.of(context).pop();
                                              },
                                            ),
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
                                          mStudentProfileProvider.editProfile(),
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

  Widget profileCard() {
    return Consumer(builder: (context, ref, _) {
      var mProvider = ref.watch(studentProfileProvider);
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
                          checkNullOrEmptyString(mProvider.profilePictureUrl) &&
                          !checkNullOrEmptyString(mProvider.name.text))
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
                    SizedBox(
                      width: 50.vw,
                      // height: 100,
                      child: Row(
                        children: [
                          Expanded(
                            child: AppText(
                              mProvider.name.text,
                              fontWeight: FontWeight.w700,
                              textSize: 21.sp,
                              textAlign: TextAlign.left,
                              lineHeight: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (mProvider.paid)
                      AppText(
                        ref
                            .read(studentHomeProvider)
                            .dashboardData!
                            .planDuration!,
                        textSize: 12.sp,
                        textColor: AppColors.grey79,
                      ),
                    // if (mProvider.paid)
                    //   //
                    //   mProvider.studentData?.courseId == 0
                    //       ? yellowLabel(AppStrings.courseType.toUpperCase())
                    //       : mProvider.studentData?.courseId == 1
                    //           ? purpleLabel()
                    //           : yellowLabel(),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
