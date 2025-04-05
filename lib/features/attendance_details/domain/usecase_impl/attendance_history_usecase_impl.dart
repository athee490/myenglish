import 'package:myenglish/features/attendance_details/data/models/attendance_details_model.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/features/attendance_details/domain/repository/attendance_repository.dart';
import 'package:myenglish/features/attendance_details/domain/usecase/attendance_history_usecase.dart';

class AttendanceHistoryUseCaseImpl implements AttendanceHistoryUseCase {
  final AttendanceRepository _repository;
  AttendanceHistoryUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, List<AttendanceDetail>>> call(
      String studentId, String fromDate, String toDate) async {
    return await _repository.getAttendanceHistory(studentId, fromDate, toDate);
  }
}
