import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';

abstract class ClassRoomRepository {
  Future<Either<Failure, bool>> sendDelayNotification(
      AppUser userType, String userId);
  Future<Either<Failure, bool>> logStudentAttendance(String callId);
  Future<Either<Failure, bool>> logTutorAttendance(String callId);
}
