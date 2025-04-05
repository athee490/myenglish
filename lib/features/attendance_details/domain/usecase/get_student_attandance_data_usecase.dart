import '../../../../core/network/either.dart';
import '../../../../core/network/error.dart';
import '../../data/models/get_student_attendance_model.dart';

abstract class GetStudentAttendanceDataUseCase {
  Future<Either<Failure, GetStudentAttendanceModel>> getAttendanceData();
}
