import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/breakout_room/domain/repository/breakout_room_repository.dart';
import 'package:myenglish/features/breakout_room/domain/usecase/report_user_usecase.dart';

class ReportUserUseCaseImpl implements ReportUserUseCase {
  final BreakoutRoomRepository _repository;
  ReportUserUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, bool>> call(
      {required String userId,
      required String callId,
      required String reason}) async {
    return await _repository.reportUser(
        userId: userId, callId: callId, reason: reason);
  }
}
