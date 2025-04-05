import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/features/breakout_room/data/datasource/breakout_room_datasource.dart';
import 'package:myenglish/features/breakout_room/data/models/breakout_room_user.dart';
import 'package:myenglish/features/breakout_room/data/models/breakout_room_data.dart';
import 'package:myenglish/features/breakout_room/data/models/broom_enabled_model.dart';
import 'package:myenglish/features/breakout_room/domain/repository/breakout_room_repository.dart';

class BreakoutRoomRepositoryImpl implements BreakoutRoomRepository {
  final BreakoutRoomDataSource _dataSource;
  BreakoutRoomRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<BreakoutRoomUser>>> getBreakoutRoomUsers(
      String callId) async {
    var result = Either<Failure, List<BreakoutRoomUser>>();
    var data = await _dataSource.getBreakoutRoomUsers(callId);
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, List<BreakoutRoomData>>> getBreakoutRooms() async {
    var result = Either<Failure, List<BreakoutRoomData>>();
    var data = await _dataSource.getBreakoutRooms();
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, bool>> joinOrLeaveRoom(
      String callId, String log) async {
    var result = Either<Failure, bool>();
    var data = await _dataSource.joinOrLeaveRoom(callId, log);
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, bool>> reportUser(
      {required String userId,
      required String callId,
      required String reason}) async {
    var result = Either<Failure, bool>();
    var data = await _dataSource.reportUser(
        userId: userId, callId: callId, reason: reason);
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, List<BRoomEnabledModel>>>
      breakoutRoomEnableList() async {
    var result = Either<Failure, List<BRoomEnabledModel>>();
    var data = await _dataSource.breakoutRoomEnableList();
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }
}
