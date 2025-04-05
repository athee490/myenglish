import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/attendance_details/data/models/home_attendance_model.dart';
import 'package:myenglish/features/attendance_details/domain/repository/attendance_repository.dart';
import 'package:myenglish/features/attendance_details/domain/usecase/attendance_log_usecase.dart';

class AttendanceLogUseCaseImpl implements AttendanceLogUseCase {
  final AttendanceRepository _repository;
  AttendanceLogUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, List<HomeAttendanceModel>>> call() async {
    return await _repository.getAttendanceLog();
  }
}
