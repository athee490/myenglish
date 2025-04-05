import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/classroom/domain/repository/classroom_repository.dart';
import 'package:myenglish/features/classroom/domain/usecase/student_attendance_usecase.dart';

class StudentAttendanceUseCaseImpl implements StudentAttendanceUseCase {
  final ClassRoomRepository _repository;
  StudentAttendanceUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, bool>> call(String callId) async {
    return await _repository.logStudentAttendance(callId);
  }
}
