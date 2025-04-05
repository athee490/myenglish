import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/features/attendance_details/data/datasource/attendance_datasource.dart';
import 'package:myenglish/features/attendance_details/data/models/get_student_attendance_model.dart';
import 'package:myenglish/features/attendance_details/data/models/home_attendance_model.dart';
import 'package:myenglish/features/attendance_details/data/models/attendance_details_model.dart';
import 'package:myenglish/features/attendance_details/domain/repository/attendance_repository.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceDataSource _dataSource;

  AttendanceRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<AttendanceDetail>>> getAttendanceHistory(
      String studentId, String fromDate, String toDate) async {
    var result = Either<Failure, List<AttendanceDetail>>();
    var data =
        await _dataSource.getAttendanceHistory(studentId, fromDate, toDate);
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, List<HomeAttendanceModel>>> getAttendanceLog() async {
    var result = Either<Failure, List<HomeAttendanceModel>>();
    var data = await _dataSource.getAttendanceLog();
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, GetStudentAttendanceModel>>
      getAttendanceData() async {
    var result = Either<Failure, GetStudentAttendanceModel>();
    var data = await _dataSource.getAttendanceData();
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }
}
