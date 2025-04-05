import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/attendance_details/data/models/home_attendance_model.dart';

abstract class AttendanceLogUseCase {
  Future<Either<Failure, List<HomeAttendanceModel>>> call();
}
