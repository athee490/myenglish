import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/breakout_room/data/models/breakout_room_user.dart';
import 'package:myenglish/features/breakout_room/domain/repository/breakout_room_repository.dart';
import 'package:myenglish/features/breakout_room/domain/usecase/get_roomusers_usecase.dart';

class GetRoomUsersUseCaseImpl implements GetRoomUsersUseCase {
  final BreakoutRoomRepository _repository;
  GetRoomUsersUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, List<BreakoutRoomUser>>> call(String callId) async {
    return await _repository.getBreakoutRoomUsers(callId);
  }
}
