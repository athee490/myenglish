import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/breakout_room/data/models/breakout_room_user.dart';

abstract class GetRoomUsersUseCase {
  Future<Either<Failure, List<BreakoutRoomUser>>> call(String callId);
}
