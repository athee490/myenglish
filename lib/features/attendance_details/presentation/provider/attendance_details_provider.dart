import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myenglish/core/widgets/toast.dart';
import 'package:myenglish/features/attendance_details/data/models/attendance_details_model.dart';
import 'package:myenglish/features/attendance_details/data/models/home_attendance_model.dart';
import 'package:myenglish/features/attendance_details/domain/usecase/attendance_history_usecase.dart';

import '../../data/models/get_student_attendance_model.dart';
import '../../domain/usecase/get_student_attandance_data_usecase.dart';

class AttendanceDetailsProvider extends ChangeNotifier {
  final AttendanceHistoryUseCase _attendanceHistoryUseCase;
  final GetStudentAttendanceDataUseCase _getStudentAttendanceDataUseCase;
  AttendanceDetailsProvider(this._attendanceHistoryUseCase,this._getStudentAttendanceDataUseCase);
  late HomeAttendanceModel studentData;
  String studentId = '';
  bool _disposed = false;
  bool isLoading = true;
  String toDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String fromDate = DateFormat('yyyy-MM-dd')
      .format(DateTime.now().subtract(const Duration(days: 30)));
  List<AttendanceDetail> attendanceList = [];

  List<GetStudentData> attendanceData = [];

  getAttendanceHistory() async {
    isLoading = true;
    // notifyListeners();
    var data =
        await _attendanceHistoryUseCase.call(studentId, fromDate, toDate);
    if (data.isLeft()) {
      showToast(data.getLeft().error);
    } else {
      attendanceList = data.getRight();
    }
    isLoading = false;
    notifyListeners();
  }


 Future<void> getStudentAttendanceData()async{
    var data = await _getStudentAttendanceDataUseCase.getAttendanceData();
    if(data.isLeft()){
      showToast(data.getLeft().error);
    }else{
      if(data.getRight().data != null && data.getRight().data!.isNotEmpty){
        attendanceData.addAll(data.getRight().data!);
      }
    }
    notifyListeners();
 }

  updateFilter(String from, String to) async {
    if (fromDate == from && toDate == to) return;
    fromDate = from;
    toDate = to;
    isLoading = true;
    notifyListeners();
    getAttendanceHistory();
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
