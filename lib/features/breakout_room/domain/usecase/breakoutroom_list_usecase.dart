import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/breakout_room/data/models/breakout_room_data.dart';

abstract class BreakoutRoomListUseCase {
  Future<Either<Failure, List<BreakoutRoomData>>> call();
}
