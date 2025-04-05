import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:fl_downloader/fl_downloader.dart';
import 'package:flutter/material.dart';
import 'package:myenglish/core/config/app_routes.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/widgets/toast.dart';
import 'package:myenglish/features/attendance_details/data/models/home_attendance_model.dart';
import 'package:myenglish/features/home/data/models/tutor_dashboard_model.dart';
import 'package:myenglish/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../../../attendance_details/data/models/get_student_attendance_model.dart';
import '../../../../course_syllabus/presentation/widget/common_widget.dart';
import '../../../../home/data/models/get_tutor_statistics_model.dart';
import '../../../../home/data/models/get_tutor_today_course_model.dart';
import '../../../../onboarding/domain/usecase/file_upload_usecase.dart';
import '../../../data/models/get_tutor_single_course_details_model.dart';
import '../../../domain/usecase/edit_tutor_course_usecase.dart';
import '../../../domain/usecase/get_tutor_course_details_usecase.dart';

class TutorCourseDetailsProvider extends ChangeNotifier {
  final EditTutorCourseUseCase _editTutorCourseUseCase;
  final GetTutorCourseDetailsUseCase _tutorCourseDetailsUseCase;
  final FileUploadUseCase _fileUploadUseCase;

  TutorCourseDetailsProvider(this._editTutorCourseUseCase,
      this._tutorCourseDetailsUseCase, this._fileUploadUseCase);

  final TextEditingController courseTitle = TextEditingController();
  final TextEditingController keyWords = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController shortDescription = TextEditingController();
  final TextEditingController longDescription = TextEditingController();
  late TextEditingController startTimeController = TextEditingController();
  late TextEditingController endTimeController = TextEditingController();

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

  List<String> enrollToTeach = ['K-12', 'Teach Any Course'];

  List<String> timeZone = [
    'IST',
    'EST',
    'CST',
    'PST',
  ];

  DateTime? fromDate;
  String? forFromDate;
  String? forToDate;
  DateTime? toDate;

  DateTime? startTime;
  DateTime? endTime;

  String selectedTimeZone = '';
  String? selectedEnroll = '';
  String selectedGrade = '';

  bool loading = true;
  bool attendanceLoading = true;
  bool _disposed = false;
  bool error = false;
  String videoUrl = '';
  String getVideoUrl = '';
  String courseId = '';
  String thumbnailPath = '';

  setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  TutorSingleCourseData? tutorSingleCourseDetails;

  TutorDashboardDetail? dashboardData;
  List<TutorLiveDetail> liveDetail = [];
  List<HomeAttendanceModel> attendanceLog = [];
  List<TutorStatisticsData> tutorStatisticsData = [];

  List<GetStudentData> getStudentAttendanceData = [];

  List<TutorTodayCourseDetails> tutorTodayCourseDetails = [];
  bool accountSuspended = false;

  final formKey = GlobalKey<FormState>();
  String documentUrl = '';

  String? validateDropDown(String? dropDownValue) {
    if (dropDownValue == null || dropDownValue.isEmpty) {
      return 'Field required'; // Error message for empty selection
    }
    return null;
  }

  updateSelectedTimeZone(String timeZone) {
    selectedTimeZone = timeZone;
    notifyListeners();
  }

  updateSelectedEnrollToTeach(String? s) {
    selectedEnroll = s;
    notifyListeners();
  }

  updateSelectedGrade(String s) {
    selectedGrade = s;
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

  checkFORGRADE() {
    if (selectedGrade == null || selectedGrade!.isEmpty) {
      notifyListeners();
      throw 'Please select a grade';
    }
  }

  void editTutorCourse() async {
    try {
      checkFORGRADE();

      if (!formKey.currentState!.validate()) return;
      setLoader(true);
      notifyListeners();
      String enrollmentParam;
      if (selectedEnroll == 'K-12') {
        enrollmentParam = "$selectedGrade Grade";
      } else {
        enrollmentParam = selectedEnroll!;
      }
      var body = {
        "timezone": selectedTimeZone,
        "title": courseTitle.text,
        "keywords": keyWords.text,
        "startTime": startTimeController.text,
        "endTime": endTimeController.text,
        "startDate": forFromDate,
        "endDate": forToDate,
        "shortDescription": shortDescription.text,
        "longDescription": longDescription.text,
        "courseIntro": videoUrl.toString(),
        "syllabus": documentUrl.toString(),
        "courseType": enrollmentParam.toString(),
        "price": price.text
      };
      print('TutorCourseReg $body');
      var data = await _editTutorCourseUseCase.editTutorCourse(body, courseId);
      setLoader(false);
      if (data.isLeft()) {
        showToast(data.getLeft().error);
      } else {
        showToast(data.getLeft().error);
        Navigator.pushNamed(
            navigatorKey.currentContext!, AppRoutes.tutorCourseDetail);
      }
    } catch (e) {
      showToast(e.toString(), type: ToastType.error);
    }
    notifyListeners();
  }

  Future<void> getSingleCourseDetails() async {
    thumbnailPath = '';
    setLoader(true);
    var data =
        await _tutorCourseDetailsUseCase.getTutorSingleCourseDetails(courseId);
    setLoader(false);
    if (data.isLeft()) {
      showToast(data.getLeft().error);
    } else {
      tutorSingleCourseDetails = data.getRight().data!.first;
      Navigator.pushNamed(
          navigatorKey.currentContext!, AppRoutes.tutorCourseDetail);
      selectedEnroll = tutorSingleCourseDetails!.courseType.toString();
      courseTitle.text = tutorSingleCourseDetails!.title.toString();
      keyWords.text = tutorSingleCourseDetails!.keyword.toString();
      price.text = tutorSingleCourseDetails!.price.toString();
      shortDescription.text =
          tutorSingleCourseDetails!.shortDescription.toString();
      longDescription.text =
          tutorSingleCourseDetails!.longDescription.toString();
      getVideoUrl = tutorSingleCourseDetails!.courseIntro.toString();
      selectedTimeZone = tutorSingleCourseDetails!.timezone.toString();
      documentUrl = tutorSingleCourseDetails!.syllabus.toString();
      forFromDate = tutorSingleCourseDetails!.startDate.toString();
      forToDate = tutorSingleCourseDetails!.endDate.toString();
      startTimeController.text = tutorSingleCourseDetails!.startTime.toString();
      endTimeController.text = tutorSingleCourseDetails!.endTime.toString();
    }
  }

  Future<void> studentPayment() async {
    setLoader(true);
    var body = {'amount': 100, 'paymentId': 12345};
    var data = await _editTutorCourseUseCase.studentPayment(body, courseId);
    setLoader(false);
    if (data.isLeft()) {
      showToast(data.getLeft().error);
    } else {
      Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.studentHome);
    }
  }

  bool uploadingVideo = false;
  PlatformFile? videoResumeFile;
  late VideoPlayerController videoPlayerController;

  void pickVideo() async {
    getVideoUrl = '';
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
    await Future.delayed(
      const Duration(seconds: 2),
      () {
        uploadingVideo = false;
        notifyListeners();
      },
    );
  }

  PlatformFile? documentProofPlatformFile;

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

  String tutorCourseId = '';
  bool isLoading = false;

  Future<void> generateThumbnail()async{
    final directory = await getTemporaryDirectory();
    final fileName = await VideoThumbnail.thumbnailFile(
      video: tutorSingleCourseDetails!.courseIntro.toString(),
      thumbnailPath: directory.path,
      imageFormat: ImageFormat.WEBP,
      maxHeight: 64,
      quality: 75,
    );
    thumbnailPath = fileName!;
    notifyListeners();
  }

  setLoader(bool value) {
    isLoading = value;
    notifyListeners();
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
