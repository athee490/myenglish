import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/breakout_room/domain/repository/breakout_room_repository.dart';
import 'package:myenglish/features/breakout_room/domain/usecase/join_room_usecase.dart';

class JoinBreakoutRoomUseCaseImpl implements JoinBreakoutRoomUseCase {
  final BreakoutRoomRepository _repository;
  JoinBreakoutRoomUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, bool>> call(String callId, String log) async {
    return await _repository.joinOrLeaveRoom(callId, log);
  }
}
