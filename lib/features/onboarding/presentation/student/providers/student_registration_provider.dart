import 'package:flutter/material.dart';
import 'package:myenglish/core/config/app_routes.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/utils/helpers/textfield_validator.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/core/widgets/toast.dart';
import 'package:myenglish/features/onboarding/domain/usecase/student_register_usecase.dart';
import 'package:myenglish/main.dart';

import '../../../../../core/constants/enums.dart';
import '../../../../course_syllabus/presentation/widget/common_widget.dart';


class StudentRegistrationProvider extends ChangeNotifier {
  final StudentRegisterUseCase _studentRegisterUseCase;

  StudentRegistrationProvider(this._studentRegisterUseCase);

  //onboarding
  int totalPages = 3;
  int pageIndex = 0;
  PageController onboardingPageController = PageController();

  updatePage(int index) {
    pageIndex = index;
    notifyListeners();
  }

//controllers
  final TextEditingController fullName = TextEditingController();
  final TextEditingController mobileNo = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController pincode = TextEditingController();
  final TextEditingController occupation = TextEditingController();
  final TextEditingController goal = TextEditingController();
  final TextEditingController qualification = TextEditingController();
  final TextEditingController reasonToJoin = TextEditingController();
  final TextEditingController expectedDoj = TextEditingController();
  final TextEditingController reason = TextEditingController();
  final TextEditingController otherLanguage = TextEditingController();
  final TextEditingController otherGrade = TextEditingController();

  String countryCode = '+1';
  String countryCodeName = 'US';
  String selectedCountry = 'United States';
  final FocusNode mobileFieldFocusNode = FocusNode();

  //password screen variables
  final TextEditingController password = TextEditingController();
  final TextEditingController confPassword = TextEditingController();
  bool passwordError = false;
  bool confPasswordError = false;

  //key
  final formKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
  bool isLoading = false;

  setLoader(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Map<String, dynamic> timings = {
    '07:00 AM to 10:00 AM': ['07:00:00', '10:00:00'],
    '10:00 AM to 01:00 PM': ['10:00:00', '13:00:00'],
    '01:00 PM to 04:00 PM': ['13:00:00', '16:00:00'],
    '04:00 PM to 07:00 PM': ['16:00:00', '19:00:00'],
    '07:00 PM to 10:00 PM': ['19:00:00', '22:00:00'],
  };

  List<String> languages = [
    'Tamil',
    'Hindi',
    'Malayalam',
    'Telugu',
    'Kannada',
    'Other'
  ];

  List<String> grades = [
    'Elementary School (1-5)',
    'Middle School (6-8)',
    'High School (9-12)',
    'Other'
  ];

  List<String> enrollToTeach = [ 'K-12','Professional Classes',];

  List<Grades> listOfGrades = [
    Grades(
        'Elementary School: Grades 1-5', ['1st', '2nd', '3rd', '4th', '5th']),
    Grades('Middle School: Grades 6-8', ['6th', '7th', '8th']),
    Grades('High School: Grades 9-12', ['9th', '10th', '11th', '12th']),
     Grades('Others', ['Others']),
  ];

  List<String>? availableTiming = ['', ''];
  List<String> howDoYouKnowAboutMef = [
    'Social Media',
    'Through a Friend',
    'Other'
  ];
  String? selectedHow = '';
  String? selectedLanguage = '';
  String? selectedEnroll = '';
  String? selectedGrade ='';

  String? validateDropDown(String? dropDownValue) {
    if (dropDownValue == null || dropDownValue.isEmpty) {
      return 'Field required'; // Error message for empty selection
    }
    return null;
  }

  updateSelectedHow(String? s) {
    selectedHow = s;
    notifyListeners();
  }

  updateSelectedLang(String? s) {
    selectedLanguage = s;
    notifyListeners();
  }

  updateSelectedEnroll(String? s) {
    selectedEnroll = s;
    notifyListeners();
  }

  updateSelectedGrade(String? grade) {
    selectedGrade = grade;
    notifyListeners();
  }

  checkForErrors() {
    if (TextFieldValidator.newPassword(password.text) == null) {
      passwordError = false;
    } else {
      passwordError = true;
    }
    if (TextFieldValidator.confirmPassword(password.text, confPassword.text) ==
        null) {
      confPasswordError = false;
    } else {
      confPasswordError = true;
    }

    notifyListeners();
  }

  // checkFORGRADE(){
  //   if (selectedGrade == null || selectedGrade!.isEmpty) {
  //     notifyListeners();
  //     throw 'Please select a grade';
  //   }
  // }

  void setPassword() async {
    try{
      // checkFORGRADE();

    if (formKey.currentState!.validate()) {
      if (selectedCountry.isEmpty) {
        showToast('Please select a country', type: ToastType.error);
        return;
      }
      Navigator.pushNamed(
          navigatorKey.currentContext!, AppRoutes.changePassword);
    }}
        catch(e){
      showToast(e.toString(),type: ToastType.error);
        }
  }

  void submit() async {
    checkForErrors();
    // checkFORGRADE();
    if (passwordFormKey.currentState!.validate() &&
        !passwordError &&
        !confPasswordError &&
        selectedLanguage != null &&
        availableTiming != null &&
        selectedHow != null) {
      FocusManager.instance.primaryFocus?.unfocus();
      setLoader(true);
      try {

        var data = await _studentRegisterUseCase.call(
          name: fullName.text,
          email: email.text,
          phoneNumber: mobileNo.text,
          phoneCode: countryCode.toString(),
          password: password.text,
          enrollment: selectedEnroll.toString(),
          grade:selectedGrade.toString(),
          country: selectedCountry.toString(),
        );
        setLoader(false);
        if (data.isLeft()) {
          if (data.getLeft().error.toLowerCase().contains('already in use')) {
            Navigator.pop(navigatorKey.currentState!.context);
            showToast(data.getLeft().error, backgroundColor: AppColors.red);
          } else {
            showToast(data.getLeft().error, backgroundColor: AppColors.red);
          }
        } else {
          showToast('User registered successfully',
              backgroundColor: Colors.green);
          Prefs().setString(Prefs.token, data.getRight());
          Prefs().setString(Prefs.userType, AppStrings.student);
          Prefs().setBool(Prefs.isLoggedIn, true);
          Prefs().setString(Prefs.email, email.text);
          Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!,
              AppRoutes.studentHome, (route) => false);
          // Navigator.pushNamed(
          //     navigatorKey.currentContext!, AppRoutes.choosePlan);
        }
      } catch (e) {
        print(e);
        showToast(e.toString());
        setLoader(false);
      }
    }
  }

  ///password
  bool hidePassword = true;

  toggleVisibility() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

  bool hideConfPassword = true;

  toggleConfPasswordVisibility() {
    hideConfPassword = !hideConfPassword;
    notifyListeners();
  }
}
