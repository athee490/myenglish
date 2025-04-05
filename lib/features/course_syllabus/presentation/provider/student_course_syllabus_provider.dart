import 'dart:async';
import 'dart:io';

import 'package:fl_downloader/fl_downloader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../core/config/app_routes.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../main.dart';
import '../../data/models/get_student_all_course_model.dart';
import '../../data/models/student_selected_course_model.dart';
import '../../domain/usecase/get_student_all_course_usecase.dart';
import '../../domain/usecase/student_selected_course_usecase.dart';
import '../widget/common_widget.dart';

class StudentCourseSyllabusProvider extends ChangeNotifier {
  final GetStudentAllCourseDetailsUseCase _getStudentAllCourseDetailsUseCase;
  final StudentSelectedCourseUseCase _studentSelectedCourseUseCase;

  StudentCourseSyllabusProvider(this._getStudentAllCourseDetailsUseCase,this._studentSelectedCourseUseCase) {
    courseListScrollController.addListener(
      () {
        if (courseListScrollController.position.maxScrollExtent ==
            courseListScrollController.position.pixels &&
        courseCurrentPage < totalPageCount) {
          print(
              'pageNo: $courseCurrentPage list length: ${courseDetails.length}');
          courseCurrentPage = courseCurrentPage + 1;
          getAllCourseList();
        }
        courseListScrollController.position.isScrollingNotifier
            .addListener(() {});
      },
    );
  }

  final TextEditingController searchCourseController = TextEditingController();
  final ScrollController courseListScrollController = ScrollController();

  String selectedGrade ='';
  bool isLoading = false;
  bool paginationLoading = false;
  int limit = 4;
  int courseCurrentPage = 1;
  int totalPageCount = 1;
  String filter = '';
  String search = '';
  String selectedCourseId = '';
  List<CourseDetails> courseDetails = [];
  SingleCourseDetails? singleCourseDetails;
  SingleCourseDetails? selectedCourse;
  String thumbnailPath = '';
  //  StreamSubscription? progressStream;
  // int progress = 0;

  List<Grades> listOfGrades = [
    Grades(
        'Elementary School: Grades 1-5', ['1st', '2nd', '3rd', '4th', '5th']),
    Grades('Middle School: Grades 6-8', ['6th', '7th', '8th']),
    Grades('High School: Grades 9-12', ['9th', '10th', '11th', '12th']),
    Grades('Others', ['Others Grade']),
  ];

  List<String> enrollToTeach = ['Learn From Expert', 'KG-12'];

  Future<void> getAllCourseList() async {
    String currentPage = courseCurrentPage.toString();
    if(selectedGrade.toLowerCase() == 'view all courses'){
      selectedGrade = 'teach any';
    }
    if (courseCurrentPage != 1) loadPagination(true);
    setLoader(true);
    var data = await _getStudentAllCourseDetailsUseCase.getAllCourseList(
        currentPage, limit.toString(), selectedGrade, search);
    setLoader(false);
    if (data.isLeft()) {
      showToast(data.getLeft().error);
    } else {
      totalPageCount = data.getRight().pageCount ?? 1;
      List<CourseDetails> tempCourseList = data.getRight().result ?? [];
      if (courseCurrentPage == 1) {
        courseDetails.clear();
      }
      courseDetails.addAll(tempCourseList);
    }
    if (courseCurrentPage != 1) loadPagination(false);
    notifyListeners();
    // Future.delayed(const Duration(seconds: 2), () => setState());
  }

  Future<void> getSingleCourse() async {
    thumbnailPath = '';
    setLoader(true);
    var data = await _studentSelectedCourseUseCase.getSingleCourseDetails(selectedCourseId);
    setLoader(false);
    if(data.isLeft()){
      showToast(data.getLeft().error);
    }else{
      singleCourseDetails = data.getRight().result!.first;
      Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.studentCourseDetail );
    }
    notifyListeners();
  }


  Future<void> generateThumbnail() async {
    final directory = await getTemporaryDirectory();
    final fileName = await VideoThumbnail.thumbnailFile(
      video: singleCourseDetails!.courseIntro
          .toString(),
      thumbnailPath: directory.path,
      imageFormat: ImageFormat.WEBP,
      maxHeight: 64,
      quality: 75,
    );
    thumbnailPath = fileName!;
    print('thumbnailPath $thumbnailPath');
    notifyListeners();
  }


  setLoader(bool value) {
    isLoading = value;
    notifyListeners();
  }

  setState() {
    notifyListeners();
  }

  loadPagination(bool value) {
    paginationLoading = value;
    notifyListeners();
  }

  searchCourseKey() {
    courseDetails.clear();
    getAllCourseList();
  }


  refreshPage() {
    if (courseCurrentPage == 1) {
      courseDetails.clear();
      getAllCourseList();
    }
  }
}
