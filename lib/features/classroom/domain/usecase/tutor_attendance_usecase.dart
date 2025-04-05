import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';

abstract class TutorAttendanceUseCase {
  Future<Either<Failure, bool>> call(String callId);
}
