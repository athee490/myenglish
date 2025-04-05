import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/features/classroom/data/datasource/classroom_datasource.dart';
import 'package:myenglish/features/classroom/domain/repository/classroom_repository.dart';

class ClassRoomRepositoryImpl implements ClassRoomRepository {
  final ClassRoomDataSource _dataSource;
  ClassRoomRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, bool>> sendDelayNotification(
      AppUser userType, String userId) async {
    var result = Either<Failure, bool>();
    var data = await _dataSource.sendDelayNotification(userType, userId);
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, bool>> logStudentAttendance(String callId) async {
    var result = Either<Failure, bool>();
    var data = await _dataSource.logStudentAttendance(callId);
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, bool>> logTutorAttendance(String callId) async {
    var result = Either<Failure, bool>();
    var data = await _dataSource.logTutorAttendance(callId);
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }
}
