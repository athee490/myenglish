import 'package:myenglish/core/network/either.dart';

import 'package:myenglish/core/network/error.dart';

import 'package:myenglish/features/attendance_details/data/models/get_student_attendance_model.dart';

import '../repository/attendance_repository.dart';
import '../usecase/get_student_attandance_data_usecase.dart';

class GetStudentAttendanceDataUseCaseImpl
    extends GetStudentAttendanceDataUseCase {
  final AttendanceRepository _attendanceDataSource;

  GetStudentAttendanceDataUseCaseImpl(this._attendanceDataSource);

  @override
  Future<Either<Failure, GetStudentAttendanceModel>>
      getAttendanceData() async {
    return await _attendanceDataSource.getAttendanceData();
  }
}
