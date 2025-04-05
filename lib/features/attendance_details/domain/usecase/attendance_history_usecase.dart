import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/attendance_details/data/models/attendance_details_model.dart';

abstract class AttendanceHistoryUseCase {
  Future<Either<Failure, List<AttendanceDetail>>> call(
      String studentId, String fromDate, String toDate);
}
