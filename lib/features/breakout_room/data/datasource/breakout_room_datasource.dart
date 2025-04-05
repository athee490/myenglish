import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/breakout_room/data/models/breakout_room_data.dart';
import 'package:myenglish/features/breakout_room/data/models/breakout_room_user.dart';
import 'package:myenglish/features/breakout_room/data/models/broom_enabled_model.dart';

abstract class BreakoutRoomDataSource {
  Future<Either<Failure, List<BreakoutRoomData>>> getBreakoutRooms();
  Future<Either<Failure, List<BreakoutRoomUser>>> getBreakoutRoomUsers(
      String callId);
  Future<Either<Failure, bool>> reportUser({
    required String userId,
    required String callId,
    required String reason,
  });
  Future<Either<Failure, bool>> joinOrLeaveRoom(String callId, String log);
  Future<Either<Failure, List<BRoomEnabledModel>>> breakoutRoomEnableList();
}
