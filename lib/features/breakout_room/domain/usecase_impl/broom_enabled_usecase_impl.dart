import 'package:myenglish/features/breakout_room/data/models/broom_enabled_model.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/features/breakout_room/domain/repository/breakout_room_repository.dart';
import 'package:myenglish/features/breakout_room/domain/usecase/broom_enabled_list_usecase.dart';

class BRoomEnabledUseCaseImpl implements BRoomEnabledListUseCase {
  final BreakoutRoomRepository _repository;
  BRoomEnabledUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, List<BRoomEnabledModel>>> call() async {
    return await _repository.breakoutRoomEnableList();
  }
}
