import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/utils/helpers/app_helpers.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/core/widgets/toast.dart';
import 'package:myenglish/features/onboarding/domain/usecase/file_upload_usecase.dart';
import 'package:myenglish/features/profile/data/models/student_profile_model.dart';
import 'package:myenglish/features/profile/domain/usecase/edit_student_profile.dart';
import 'package:myenglish/features/profile/domain/usecase/get_student_profile.dart';
import 'package:myenglish/features/profile/presentation/widgets/image_picker_sheet.dart';
import 'package:myenglish/main.dart';

import '../../../course_syllabus/presentation/widget/common_widget.dart';
import '../../../home/domain/usecase/student_dashboard_usecase.dart';

class StudentProfileProvider extends ChangeNotifier {
  // final StudentDashboardUseCase _studentDashboardUseCase;
  final GetStudentProfileUseCase _studentProfileUseCase;
  final EditStudentProfileUseCase _editStudentProfileUseCase;
  final FileUploadUseCase _fileUploadUseCase;

  StudentProfileProvider(
      // this._studentDashboardUseCase,
      this._studentProfileUseCase,
      this._editStudentProfileUseCase,
      this._fileUploadUseCase);

  final name = TextEditingController(text: ' ');
  final mobileNo = TextEditingController();
  final email = TextEditingController();
  final dob = TextEditingController();
  final pincode = TextEditingController();
  final occupation = TextEditingController();
  final education = TextEditingController();
  final otherGrade = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool paid = false;
  File? profilePicFile;
  String? profilePictureUrl;
  bool _disposed = false;
  List<StudentProfileDetails> studentDetails = [];
  StudentProfileModel? studentData;
  String countryCode = '+1';
  String countryCodeName = 'US';
  String selectedCountry = 'United States';
  String selectedCountryCode = '';
  String selectedEnroll = '';
  String selectedGrade = '';

  bool isLoading = false;

  List<String> enrollToTeach = [ 'K-12','Professional Classes',];

  List<Grades> listOfGrades = [
    Grades(
        'Elementary School: Grades 1-5', ['1st', '2nd', '3rd', '4th', '5th']),
    Grades('Middle School: Grades 6-8', ['6th', '7th', '8th']),
    Grades('High School: Grades 9-12', ['9th', '10th', '11th', '12th']),
    Grades('Others', ['Others']),
  ];

  List<String> grades = [
    'Elementary School (1-5)',
    'Middle School (6-8)',
    'High School (9-12)',
    'Other'
  ];

  setLoader(bool value) {
    isLoading = value;
    notifyListeners();
  }

  String? validateDropDown(String? dropDownValue) {
    if (dropDownValue == null || dropDownValue.isEmpty) {
      return 'Field required'; // Error message for empty selection
    }
    return null;
  }

  updateSelectedEnroll(String s) {
    selectedEnroll = s;
    notifyListeners();
  }

  updateSelectedGrade(String grade) {
    selectedGrade = grade;
    notifyListeners();
  }

  void updateSelectedCountry(String? country) {
    selectedCountry = country!;
    notifyListeners();
  }

  void updateSelectedCountryCode(String? countryCode) {
    selectedCountryCode = countryCode!;
    notifyListeners();
  }

  void checkFORGRADE() {
    if (selectedGrade == null || selectedGrade.isEmpty) {
      notifyListeners();
      throw 'Please select a grade';
    }
  }

  bool accountSuspended = false;

  // Future<void> getDashboard() async {
  //   setLoader(true);
  //   var data = await _studentDashboardUseCase.call();
  //   setLoader(false);
  //   if (data.isLeft()) {
  //     print('212121 data ${data.getLeft().error.toString()}');
  //     if (data.getLeft().error.toString().toLowerCase().contains('suspended')) {
  //       print('212121 data if');
  //       accountSuspended = true;
  //       notifyListeners();
  //     } else {
  //       showToast(data.getLeft().error, type: ToastType.error);
  //     }
  //   } else {
  //     print('212121 data else');
  //     accountSuspended = false;
  //     getProfile();
  //   }
  // }

  Future<void> getProfile() async {
    setLoader(true);
    var data = await _studentProfileUseCase.call();
    setLoader(false);
    if (data.isLeft()) {
      showToast(data.getLeft().error, type: ToastType.error);
    } else {
      if (data.getRight().data != null && data.getRight().data!.isNotEmpty) {
        studentDetails.addAll(data.getRight().data!);
        name.text = studentDetails.first.name.toString();
        mobileNo.text = studentDetails.first.phoneNumber.toString();
        email.text = studentDetails.first.email.toString();
        selectedCountry = studentDetails.first.country.toString();
        selectedEnroll = studentDetails.first.enrollment.toString();
        selectedGrade = studentDetails.first.grade.toString();
        print("api grade ${studentDetails.first.grade.toString()}");
        print("selected grade $selectedGrade");
        await Prefs().setString(Prefs.name, studentDetails.first.name ?? '');
      } else {
        showToast('No student profile data found', type: ToastType.info);
      }
    }
    notifyListeners();
  }

  Future<void> editProfile() async {
    try{
      checkFORGRADE();

    isLoading = true;
    notifyListeners();
    String enrollmentParam;
    if (selectedEnroll == 'K-12') {
      enrollmentParam = "$selectedGrade Grade";
    } else {
      enrollmentParam = selectedEnroll;
    }
    var data = await _editStudentProfileUseCase.call(
      name: name.text,
      enrollment: enrollmentParam,
      country: selectedCountry.toString(),
      phoneCode: selectedCountryCode.toString(),
    );
    isLoading = false;
    if (data.isLeft()) {
      showToast(data.getLeft().error, type: ToastType.error);
    } else {
      await Prefs().setString(Prefs.name, name.text);
      showToast('Profile Updated Successfully', type: ToastType.success);
      getProfile();
      Navigator.pop(navigatorKey.currentContext!);
    }}
        catch(e){
      showToast(e.toString(),type: ToastType.error);
        }
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
        },
    );
  }

  bool areChangesMade() {
    try {
      return !(name.text == studentDetails.first.name &&
          selectedCountry == studentDetails.first.country &&
          selectedEnroll == studentDetails.first.enrollment);
    } catch (e) {
      return false;
    }
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
