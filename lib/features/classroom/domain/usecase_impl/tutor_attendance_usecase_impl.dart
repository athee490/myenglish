import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/features/classroom/domain/repository/classroom_repository.dart';
import 'package:myenglish/features/classroom/domain/usecase/tutor_attendance_usecase.dart';

class TutorAttendanceUseCaseImpl implements TutorAttendanceUseCase {
  final ClassRoomRepository _repository;
  TutorAttendanceUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, bool>> call(String callId) async {
    return await _repository.logTutorAttendance(callId);
  }
}
