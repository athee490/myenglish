import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/attendance_details/data/models/attendance_details_model.dart';
import 'package:myenglish/features/attendance_details/data/models/home_attendance_model.dart';

import '../../data/models/get_student_attendance_model.dart';

abstract class AttendanceRepository {
  Future<Either<Failure, List<HomeAttendanceModel>>> getAttendanceLog();
  Future<Either<Failure, GetStudentAttendanceModel>> getAttendanceData();
  Future<Either<Failure, List<AttendanceDetail>>> getAttendanceHistory(
      String studentId, String fromDate, String toDate);
}
