import 'package:myenglish/features/breakout_room/data/models/breakout_room_data.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/features/breakout_room/domain/repository/breakout_room_repository.dart';
import 'package:myenglish/features/breakout_room/domain/usecase/breakoutroom_list_usecase.dart';

class BreakoutRoomListUseCaseImpl implements BreakoutRoomListUseCase {
  final BreakoutRoomRepository _repository;

  BreakoutRoomListUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, List<BreakoutRoomData>>> call() async {
    return await _repository.getBreakoutRooms();
  }
}
