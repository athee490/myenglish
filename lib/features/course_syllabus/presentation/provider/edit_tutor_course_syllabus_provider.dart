import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/widgets/toast.dart';
import '../../../onboarding/domain/usecase/file_upload_usecase.dart';
import '../widget/common_widget.dart';

class EditTutorCourseSyllabusProvider extends ChangeNotifier {
  final FileUploadUseCase _fileUploadUseCase;
  // final AttendanceHistoryUseCase _attendanceHistoryUseCase;

  EditTutorCourseSyllabusProvider(
    this._fileUploadUseCase,
    // this._attendanceHistoryUseCase
  );

  final TextEditingController title = TextEditingController();
  final TextEditingController keyWords = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController shortDescription = TextEditingController();
  final TextEditingController longDescription = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  List<Grades> listOfGrades = [
    Grades(
        'Elementary School: Grades KG-5', ['1st', '2nd', '3rd', '4th', '5th']),
    Grades('Middle School: Grades 6-8', ['6th', '7th', '8th']),
    Grades('High School: Grades 9-12', ['9th', '10th', '11th', '12th']),
    // Grades('Others', ['Others']),
  ];

  List<String> grades = [
    'Elementary School (1-5)',
    'Middle School (6-8)',
    'High School (9-12)',
    'Other'
  ];

  List<String> enrollToTeach = ['Teach Any Course', 'KG-12'];

  List<String> timeZone = [
    'IST',
    'EST',
    'CST',
    'PST',
  ];

  DateTime? fromDate;
  DateTime? toDate;

  DateTime? startTime;
  DateTime? endTime;

  String selectedTimeZone = '';
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

  void setStartTime(DateTime time) {
    startTime = time;
    notifyListeners();
  }

  void setEndTime(DateTime time) {
    endTime = time;
    notifyListeners();
  }

  String studentId = '';
  bool isLoading = false;

  setLoader(bool value) {
    isLoading = value;
    notifyListeners();
  }

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

  String videoUrl = '';
  bool uploadingVideo = false;
  PlatformFile? videoResumeFile;
  late VideoPlayerController videoPlayerController;

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
}
