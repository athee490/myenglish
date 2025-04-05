import 'package:flutter/material.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/widgets/toast.dart';
import 'package:myenglish/features/resources/data/models/syllabus_model.dart';
import 'package:myenglish/features/resources/domain/usecase/get_syllabus_usecase.dart';

import '../../../home/data/models/student_dashboard_model.dart';
import '../../../home/domain/usecase/student_dashboard_usecase.dart';

class SyllabusProvider extends ChangeNotifier {
  // final StudentDashboardUseCase _studentDashboardUseCase;
  final GetSyllabusUseCase _getSyllabusUseCase;

  SyllabusProvider(
    // this._studentDashboardUseCase,
    this._getSyllabusUseCase,
  );

  CourseLevel courseLevel = CourseLevel.all;
  List<SyllabusModel> documentList = [];
  bool isLoading = true;

  setLoader(bool value) {
    isLoading = value;
    notifyListeners();
  }

  bool accountSuspended = false;
  DashboardDetail? dashboardData;

  // Future<void> getDashboard() async {
  //   setLoader(true);
  //   var data = await _studentDashboardUseCase.call();
  //   setLoader(false);
  //   if (data.isLeft()) {
  //     print('212121 data ${data.getLeft().error.toString()}');
  //     if (data.getLeft().error.toString().toLowerCase().contains('suspended')) {
  //       accountSuspended = true;
  //       notifyListeners();
  //     } else {
  //       showToast(data.getLeft().error, type: ToastType.error);
  //     }
  //   } else {
  //     accountSuspended = false;
  //     dashboardData = data.getRight().dashboardDetails?.first;
  //     getSyllabus();
  //   }
  // }

  Future<void> getSyllabus() async {
    setLoader(true);
    var data = await _getSyllabusUseCase.call(courseLevel);
    setLoader(false);
    if (data.isLeft()) {
      showToast(data.getLeft().error, type: ToastType.error);
    } else {
      documentList = data.getRight();
      notifyListeners();
    }
  }

  updateFilter(CourseLevel level) {
    courseLevel = level;
    getSyllabus();
  }
}
