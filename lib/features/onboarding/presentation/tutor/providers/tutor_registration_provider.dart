import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:myenglish/core/config/app_routes.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/utils/helpers/textfield_validator.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/core/widgets/toast.dart';
import 'package:myenglish/features/onboarding/domain/usecase/file_upload_usecase.dart';
import 'package:myenglish/features/onboarding/domain/usecase/tutor_register_usecase.dart';
import 'package:myenglish/main.dart';
import 'package:video_player/video_player.dart';

import '../../../../course_syllabus/presentation/widget/common_widget.dart';


class TutorRegistrationProvider extends ChangeNotifier {
  final TutorRegisterUseCase _tutorRegisterUseCase;
  final FileUploadUseCase _fileUploadUseCase;

  TutorRegistrationProvider(
      this._tutorRegisterUseCase, this._fileUploadUseCase);

  //onboarding
  int totalPages = 3;
  int pageIndex = 0;
  PageController onboardingPageController = PageController();

  updatePage(int index) {
    pageIndex = index;
    notifyListeners();
  }

//controllers
  // final TextEditingController fullName = TextEditingController(text: 'Tutor 3');
  // final TextEditingController mobileNo =
  //     TextEditingController(text: '8789878987');
  // final TextEditingController email =
  //     TextEditingController(text: 'tutor3@gmail.com');
  // final TextEditingController dob = TextEditingController(text: '1999-09-13');
  // final TextEditingController pincode = TextEditingController(text: '600999');
  // final TextEditingController occupation = TextEditingController(text: 'Tutor');
  // final TextEditingController qualification = TextEditingController(text: 'BE');
  // final TextEditingController expectedDoj =
  //     TextEditingController(text: '2023-01-13');

  final TextEditingController fullName = TextEditingController();
  final TextEditingController mobileNo = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController pincode = TextEditingController();
  final TextEditingController occupation = TextEditingController();
  final TextEditingController qualification = TextEditingController();
  final TextEditingController expectedDoj = TextEditingController();
  final TextEditingController otherGrade = TextEditingController();
  final TextEditingController accNo = TextEditingController();
  final TextEditingController accName = TextEditingController();
  final TextEditingController ifsc = TextEditingController();
  final TextEditingController bankName = TextEditingController();

  //
  bool isLoading = false;

  setLoader(bool value) {
    isLoading = value;
    notifyListeners();
  }

  //password screen variables
  final TextEditingController password = TextEditingController();
  final TextEditingController confPassword = TextEditingController();
  final TextEditingController reason = TextEditingController();
  bool passwordError = false;
  bool confPasswordError = false;

  //key
  final formKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
  List<String> documents = [
    'Driving License',
    'Passport'
  ];
  String? selectedDocument = '';
  List<String> howDoYouKnowAboutMef = [
    'Social Media',
    'Through a Friend',
    'Other'
  ];

  List<Grades> listOfGrades = [
    Grades(
        'Elementary School: Grades 1-5', ['1st', '2nd', '3rd', '4th', '5th']),
    Grades('Middle School: Grades 6-8', ['6th', '7th', '8th']),
    Grades('High School: Grades 9-12', ['9th', '10th', '11th', '12th']),
    // Grades('Others', ['Others']),
  ];

  List<String> listOfShortGrades = [
    'Elementary School (1-5)',
    'Middle School (6-8)',
    'High School (9-12)'
  ];

  List<String> enrollToTeach = [ 'K-12','Teach Any Course',];

  String? selectedHow = '';
  String countryCode = '+1';
  String countryCodeName = 'US';
  String selectedCountry = 'United States';
  String? selectedGrade = '';
  String? selectedEnroll = '';

  String? validateDropDown(String? dropDownValue) {
    if (dropDownValue == null || dropDownValue.isEmpty) {
      return 'Field required'; // Error message for empty selection
    }
    return null;
  }

  updateSelectedEnrollToTeach(String? s) {
    selectedEnroll = s;
    notifyListeners();
  }

  updateSelectedDocument(String? s) {
    selectedDocument = s;
    notifyListeners();
  }

  updateSelectedGrade(String? grade) {
    selectedGrade = grade;
    notifyListeners();
  }

  updateSelectedHow(String? s) {
    selectedHow = s;
    notifyListeners();
  }


  checkFORGRADE(){
    if (selectedGrade == null || selectedGrade!.isEmpty) {
      notifyListeners();
      throw 'Please select a grade';
    }
  }


  checkFORDocument(){
    if (selectedDocument == null || selectedDocument!.isEmpty) {
      notifyListeners();
      throw 'Please select a Document';
    }
  }

  //file picker
  PlatformFile? documentProofPlatformFile;

  String documentUrl = '';

  void pickDocument() async {
    documentUrl = '';
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowCompression: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );
    if (result != null) {
      documentProofPlatformFile = result.files.first;
      print(documentProofPlatformFile!.name);
      print(documentProofPlatformFile!.bytes);
      print(documentProofPlatformFile!.size);
      print(documentProofPlatformFile!.extension);
      print(documentProofPlatformFile!.path);
      setLoader(true);
      var response =
          await _fileUploadUseCase.call(File(documentProofPlatformFile!.path!));
      setLoader(false);
      if (response.isLeft()) {
        showToast(response.getLeft().error);
      } else {
        print('212121 document url ${response.getRight()}');
        documentUrl = response.getRight();
      }
    }
  }

  bool uploadingVideo = false;
  PlatformFile? videoResumeFile;
  late VideoPlayerController videoPlayerController;

  String videoUrl = '';

  void pickVideo() async {
    videoUrl = '';
    uploadingVideo = true;
    notifyListeners();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowCompression: true,
      type: FileType.video,
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      if (file.size > 52428800) {
        showToast('File should not be greater than 50 MB');
        return;
      }
      videoPlayerController = VideoPlayerController.file(File(file.path!));
      await videoPlayerController.initialize();
      int durationInSeconds = videoPlayerController.value.duration.inSeconds;
      if (durationInSeconds < 60 || durationInSeconds > 180) {
        showToast('Video duration should be 1 - 3 mins');
        return;
      }
      videoResumeFile = file;
      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);
      notifyListeners();
      setLoader(true);
      var response =
          await _fileUploadUseCase.call(File(videoResumeFile!.path!));
      setLoader(false);
      if (response.isLeft()) {
        showToast(response.getLeft().error);
      } else {
        print('212121 video url ${response.getRight()}');
        videoUrl = response.getRight();
      }
    }
    await Future.delayed(const Duration(seconds: 2), () {
      uploadingVideo = false;
      notifyListeners();
    });
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

  void saveAndContinue() {
    try {
      checkFORGRADE();
      checkFORDocument();
      if (!formKey.currentState!.validate()) return;

      if (selectedCountry.isEmpty) {
        showToast('Please select a country', type: ToastType.error);
        return;
      }
      if (videoResumeFile == null) {
        showToast('Upload video resume', type: ToastType.error);
        return;
      }
      if (documentProofPlatformFile == null) {
        showToast('Upload document', type: ToastType.error);
        return;
      }

      Navigator.pushNamed(
          navigatorKey.currentContext!, AppRoutes.changePassword);
    }
    catch(e){
      showToast(e.toString(),type: ToastType.error);
    }
  }

  void submit() async {
    checkForErrors();
    checkFORGRADE();
    checkFORDocument();
    if (passwordFormKey.currentState!.validate() &&
        !passwordError &&
        !confPasswordError &&
        selectedDocument != null &&
        selectedHow != null) {
      FocusManager.instance.primaryFocus?.unfocus();
      setLoader(true);
      //upload file
      try {
        //register api
        var data = await _tutorRegisterUseCase.call(
          name:fullName.text,
          email: email.text,
          phoneNumber: mobileNo.text,
          phoneCode:countryCode,
          videoResume: videoUrl,
          password: password.text,
          occupation: occupation.text.trim(),
          education:qualification.text.trim(),
          country:selectedCountry.toString(),
          documentType: selectedDocument.toString(),
          documentLink:documentUrl,
          bankName:bankName.text,
          ifsc:ifsc.text,
          userName:accName.text,
          bankAccountNumber:accNo.text,
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
          Prefs().setString(Prefs.userType, AppStrings.tutor);
          Prefs().setBool(Prefs.isLoggedIn, true);
          Prefs().setString(Prefs.email, email.text);
          Navigator.pushNamed(
              navigatorKey.currentContext!, AppRoutes.tutorHomeTab);
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
