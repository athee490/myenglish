import 'dart:io';
import 'package:flutter/material.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/utils/helpers/app_helpers.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/core/widgets/toast.dart';
import 'package:myenglish/features/onboarding/domain/usecase/file_upload_usecase.dart';
import 'package:myenglish/features/profile/data/models/tutor_profile_model.dart';
import 'package:myenglish/features/profile/domain/usecase/edit_tutor_profile.dart';
import 'package:myenglish/features/profile/domain/usecase/get_tutor_profile.dart';
import 'package:myenglish/features/profile/presentation/widgets/image_picker_sheet.dart';
import 'package:myenglish/main.dart';

import '../../../course_syllabus/presentation/widget/common_widget.dart';

class TutorProfileProvider extends ChangeNotifier {
  final GetTutorProfileUseCase _tutorProfileUseCase;
  final EditTutorProfileUseCase _editTutorProfileUseCase;
  final FileUploadUseCase _fileUploadUseCase;

  TutorProfileProvider(
    this._tutorProfileUseCase,
    this._editTutorProfileUseCase,
    this._fileUploadUseCase,
  );

  final name = TextEditingController(text: ' ');
  final mobileNo = TextEditingController();
  final email = TextEditingController();
  final dob = TextEditingController();
  final pincode = TextEditingController();
  final occupation = TextEditingController();
  final qualification = TextEditingController();
  final accNo = TextEditingController();
  final accName = TextEditingController();
  final ifsc = TextEditingController();
  final accType = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String countryCode = '+1';
  String countryCodeName = 'US';
  String selectedCountry = 'United States';
  String? selectedEnroll = '';
  File? profilePicFile;
  String? profilePictureUrl;

  // TutorProfileModel? tutorData;

  List<TutorProfileDetails> tutorProfileDetails = [];
  bool disposed = false;
  bool canEdit = true;
  bool isLoading = false;

  List<String> enrollToTeach = ['K-12','Teach Any Course'];

  List<Grades> listOfGrades = [
    Grades(
        'Elementary School: Grades KG-5', ['1st', '2nd', '3rd', '4th', '5th']),
    Grades('Middle School: Grades 6-8', ['6th', '7th', '8th']),
    Grades('High School: Grades 9-12', ['9th', '10th', '11th', '12th']),
    // Grades('Others', ['Others']),
  ];

  updateSelectedEnrollToTeach(String? s) {
    selectedEnroll = s;
    notifyListeners();
  }

  String? validateDropDown(String? dropDownValue) {
    if (dropDownValue == null || dropDownValue.isEmpty) {
      return 'Field required'; // Error message for empty selection
    }
    return null;
  }

  setLoader(bool value) {
    isLoading = value;
    notifyListeners();
  }

  checkDate() {
    DateTime now = DateTime.now();
    if (now.day <= 25) {
      canEdit = false;
    }
  }

  bool accountSuspended = false;

  // Future<void> getDashboard() async {
  //   accountSuspended = false;
  //   setLoader(true);
  //   var data = await _tutorDashboardUseCase.call();
  //   setLoader(false);
  //   if (data.isLeft()) {
  //     if (data.getLeft().error.toString().toLowerCase().contains('suspended')) {
  //       accountSuspended = true;
  //       notifyListeners();
  //     } else {
  //       showToast(data.getLeft().error, type: ToastType.error);
  //     }
  //   } else {
  //     accountSuspended = false;
  //     getTutorProfile();
  //   }
  // }

  Future<void> getTutorProfile() async {
    setLoader(true);
    var data = await _tutorProfileUseCase.call();
    print('22222: $data');
    setLoader(false);
    if (data.isLeft()) {
      showToast(data.getLeft().error, type: ToastType.error);
    } else {
      tutorProfileDetails.addAll(data.getRight().data!);
      name.text = tutorProfileDetails.first.name.toString();
      email.text = tutorProfileDetails.first.email.toString();
      mobileNo.text = tutorProfileDetails.first.phoneNumber.toString();
      selectedCountry = tutorProfileDetails.first.country.toString();
      occupation.text = tutorProfileDetails.first.occupation.toString();
      accNo.text = tutorProfileDetails.first.accountNumber.toString();
      accType.text = tutorProfileDetails.first.bankName.toString();
      ifsc.text = tutorProfileDetails.first.ifsc.toString();
      accName.text = tutorProfileDetails.first.userName.toString();
      await Prefs().setString(Prefs.name, tutorProfileDetails.first.name ?? '');
    }
    notifyListeners();
  }

  editProfile() async {
    var data = await _editTutorProfileUseCase.call(
        name: name.text,
        occupation: occupation.text,
        country: selectedCountry.toString(),
        bankName: accType.text,
        ifsc: ifsc.text,
        bankAccountNumber: accNo.text,
        userName: accName.text);
    if (data.isLeft()) {
      showToast(data.getLeft().error, type: ToastType.error);
    } else {
      await Prefs().setString(Prefs.name, name.text);
      showToast('Profile Updated Successfully', type: ToastType.success);
      await Future.delayed(const Duration(milliseconds: 500));
      Navigator.pop(navigatorKey.currentState!.context);
    }
    notifyListeners();
  }

  pickImage() async {
    showModalBottomSheet(
        context: navigatorKey.currentContext!,
        builder: (_) {
          return ImagePickerSheet(
            uploadedFile: (s) {
              profilePicFile = s;
              notifyListeners();
            },
            isProfilePresented: profilePictureUrl == null ? true : false,
          );
        });
  }

  bool areChangesMade() {
    try {
      return !(name.text == tutorProfileDetails.first.name &&
          email.text == tutorProfileDetails.first.email &&
          mobileNo.text == tutorProfileDetails.first.phoneNumber &&
          selectedCountry == tutorProfileDetails.first.country &&
          occupation.text == tutorProfileDetails.first.occupation &&
          accNo.text == tutorProfileDetails.first.accountNumber &&
          accType.text == tutorProfileDetails.first.bankName &&
          ifsc.text == tutorProfileDetails.first.ifsc &&
          accName.text == tutorProfileDetails.first.userName);
    } catch (e) {
      return false;
    }
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }
}
